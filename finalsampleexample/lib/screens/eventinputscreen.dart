import 'package:finalsampleexample/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailsPage extends StatefulWidget {
  final DateTime selectedDate;

  const EventDetailsPage(this.selectedDate, {super.key});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventTimeController = TextEditingController();

  void saveEvent(CalendarData calendarData) {
    final eventName = eventNameController.text;
    final eventTime = eventTimeController.text;

    if (eventName.isEmpty || eventTime.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Required Fields'),
            content: const Text(
              'Both event name and event time are required.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      calendarData.addData(widget.selectedDate, eventName);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<CalendarData>(
          builder: (context, calendarData, child) {
            return Column(
              children: [
                TextField(
                  controller: eventNameController,
                  decoration: const InputDecoration(labelText: 'Event Name'),
                ),
                TextField(
                  controller: eventTimeController,
                  decoration: const InputDecoration(labelText: 'Event Time'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => saveEvent(calendarData),
                  child: const Text('Save'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
