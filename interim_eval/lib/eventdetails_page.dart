import 'package:flutter/material.dart';
import 'package:interim_eval/providers.dart';
import 'package:provider/provider.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendarData = Provider.of<CalendarData>(context);
    DateTime selectedDate = calendarData.selectedDate;
    String eventName = '';
    String eventTime = '';

    void saveEvent() {
      final event = '$eventName at $eventTime';
      calendarData.addEvent(selectedDate, event);
      Navigator.pop(context, calendarData.eventsData); // Pass the updated eventsData back to the previous page
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Event Name'),
              onChanged: (value) {
                eventName = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Event Time'),
              onChanged: (value) {
                eventTime = value;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveEvent,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
