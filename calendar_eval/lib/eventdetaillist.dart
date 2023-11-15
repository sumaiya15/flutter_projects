import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  final int date;

  const EventDetailsPage({super.key, required this.date}) ;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late String eventName;
  late String eventTime;
  Map<DateTime, List<String>> eventsData = {};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details - ${widget.date}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  eventName = value;
                });
              },
              decoration:const InputDecoration(
                labelText: 'Event Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  eventTime = value;
                });
              },
              decoration:const InputDecoration(
                labelText: 'Event Time',
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Save the event details and navigate back
                saveEvent(context, eventName, widget.date);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void saveEvent(BuildContext context, String eventName, int date) {
    final event = ' $eventName';
    addEvent(DateTime.fromMillisecondsSinceEpoch(date), event);
    Navigator.pop(context, EventDetails(eventName: eventName, eventTime: eventTime));
  }

  void addEvent(DateTime date, String event) {
    if (!eventsData.containsKey(date)) {
      eventsData[date] = [];
    }
    eventsData[date]!.add(event);
  }
}

class EventDetails {
  final String eventName;
  final String eventTime;

  EventDetails({
    required this.eventName,
    required this.eventTime,
  });
}
