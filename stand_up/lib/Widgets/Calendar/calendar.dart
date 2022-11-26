import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stand_up/Pages/Calendar/event_editor_page.dart';
import 'package:stand_up/Widgets/Calendar/event_provider.dart';
import 'package:stand_up/Widgets/Calendar/event_data_source.dart';
import 'package:stand_up/Widgets/Calendar/event_timeline.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        initialSelectedDate: DateTime.now(),
        dataSource: EventDataSource(events),
        cellBorderColor: Colors.transparent,
        onLongPress: (details) {
          final provider = Provider.of<EventProvider>(context, listen: false);
          provider.setDate(details.date!);
          showModalBottomSheet(
            context: context,
            builder: (context) => const EventTimeline(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EventEditorPage())),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
