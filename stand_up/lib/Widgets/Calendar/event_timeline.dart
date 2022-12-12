import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stand_up/Pages/Calendar/event_viewer.dart';
import 'package:stand_up/Widgets/Calendar/event_data_source.dart';
import 'package:stand_up/Widgets/Calendar/event_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventTimeline extends StatefulWidget {
  const EventTimeline({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _EventTimelineState createState() => _EventTimelineState();
}

class _EventTimelineState extends State<EventTimeline> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;
    if (selectedEvents.isEmpty) {
      return const Center(
        child: Text(
          "No Events Found!",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      );
    }
    return SfCalendar(
      view: CalendarView.timelineDay,
      dataSource: EventDataSource(provider.events),
      initialDisplayDate: provider.selectedDate,
      onTap: (details) {
        if (details.appointments == null) {
          return;
        }
        final event = details.appointments!.first;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EventViewer(event: event)));
      },
    );
  }
}
