import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class EventsListPage extends StatelessWidget {
  const EventsListPage({
    Key? key,
    required this.events,
  }) : super(key: key);

  final List<CalendarEventData> events;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: events
            .map(
              (event) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  event.title,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
