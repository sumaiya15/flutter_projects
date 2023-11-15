import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  final DateTime selectedDate;
  final Map<DateTime, List<String>> eventsData;

  const EventDetailsPage({super.key, 
    required this.selectedDate,
    required this.eventsData,
  });

  @override
  // ignore: no_logic_in_create_state
  State<EventDetailsPage> createState() => _EventDetailsPageState(selectedDate: selectedDate,
        eventsData: eventsData,
      );
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  DateTime selectedDate;
  Map<DateTime, List<String>> eventsData;
  String eventName = '';
  String eventTime = '';

  _EventDetailsPageState({
    required this.selectedDate,
    required this.eventsData,
  });

  void _saveEvent() {
    // Save the event details to the eventsData map.
    setState(() {
      if (!eventsData.containsKey(selectedDate)) {
        eventsData[selectedDate] = [];
      }
      eventsData[selectedDate]!.add('$eventName at $eventTime');
    });

    // Navigate back to the previous page and pass the updated eventsData as a result.
    Navigator.pop(context, eventsData);
  }

  @override
  Widget build(BuildContext context) {
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
                setState(() {
                  eventName = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Event Time'),
              onChanged: (value) {
                setState(() {
                  eventTime = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveEvent,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
