import 'package:flutter/material.dart';
import 'package:stand_up/Objects/event.dart';
import 'package:stand_up/Pages/Calendar/event_editor_page.dart';

class EventViewer extends StatelessWidget {
  final Event event;

  const EventViewer({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: viewActions(context, event),
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: <Widget>[
          buildDateTime(event),
          const SizedBox(
            height: 32,
          ),
          Text(
            event.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text(
            event.description,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  List<Widget> viewActions(BuildContext context, Event event) {
    return [
      IconButton(
          onPressed: () =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => EventEditorPage(
                        event: event,
                      ))),
          icon: const Icon(Icons.edit))
    ];
  }

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        buildDate(event.isAllDay ? "All-Day" : "From", event.from),
        if (!event.isAllDay) buildDate("To", event.to)
      ],
    );
  }

  Widget buildDate(String title, DateTime date) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(title),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(date.toString()),
        ),
      ],
    );
  }
}
