import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stand_up/Objects/event.dart';
import 'package:stand_up/Widgets/Calendar/event_provider.dart';

class EventEditorPage extends StatefulWidget {
  // TODO: Add support for a description field
  // TODO: Save and load these events from a database
  final Event? event;
  const EventEditorPage({super.key, this.event});
  @override
  _EventEditorPageState createState() => _EventEditorPageState();
}

class _EventEditorPageState extends State<EventEditorPage> {
  final titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    } else {
      final event = widget.event;
      titleController.text = event!.title;
      fromDate = event.from;
      toDate = event.to;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: buildEditingActions(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitle(),
              const SizedBox(
                height: 12,
              ),
              buildDateTimeFields(),
            ],
          ),
        ),
      ),
    );
  }

  String makeIntoDateString(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    return date;
  }

  String toTimeString(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    return time;
  }

  List<Widget> buildEditingActions() {
    return [
      ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: saveForm,
          icon: const Icon(Icons.done),
          label: const Text("SAVE"))
    ];
  }

  Widget buildTitle() {
    return TextFormField(
      style: const TextStyle(fontSize: 24),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        hintText: "Add Text",
      ),
      onFieldSubmitted: (_) => saveForm(),
      validator: (title) =>
          title != null && title.isEmpty ? "Title cannot be empty" : null,
      controller: titleController,
    );
  }

  Widget buildDateTimeFields() {
    return Column(
      children: [
        buildFromDateField(),
        buildToDateField(),
      ],
    );
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      if (date == null) {
        return null;
      }
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final pickedTime = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (pickedTime == null) {
        return null;
      }
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: pickedTime.hour, minutes: pickedTime.minute);
      return date.add(time);
    }
  }

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) {
      return;
    }
    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() {
      fromDate = date;
    });
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) {
      return;
    }
    setState(() {
      fromDate = date;
    });
  }

  Widget buildFromDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "FROM",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ListTile(
                onTap: () {
                  pickFromDateTime(pickDate: true);
                },
                trailing: const Icon(Icons.arrow_drop_down),
                title: Text(
                  makeIntoDateString(fromDate),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                onTap: () {
                  pickFromDateTime(pickDate: false);
                },
                trailing: const Icon(Icons.arrow_drop_down),
                title: Text(
                  toTimeString(fromDate),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildToDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "TO",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ListTile(
                onTap: () {
                  pickToDateTime(pickDate: true);
                },
                trailing: const Icon(Icons.arrow_drop_down),
                title: Text(
                  makeIntoDateString(toDate),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                onTap: () {
                  pickToDateTime(pickDate: false);
                },
                trailing: const Icon(Icons.arrow_drop_down),
                title: Text(
                  toTimeString(toDate),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final event = Event(
        title: titleController.text,
        from: fromDate,
        to: toDate,
        isAllDay: false,
      );
      final isEditing = widget.event != null;
      final provider = Provider.of<EventProvider>(context, listen: false);
      if (isEditing) {
        provider.editEvent(event, widget.event!);
      } else {
        provider.addEvent(event);
      }
      Navigator.of(context).pop();
    }
  }
}
