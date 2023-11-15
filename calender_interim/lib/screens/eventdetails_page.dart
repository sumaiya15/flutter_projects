import 'package:calender_interim/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

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
            final TextEditingController eventNameController = TextEditingController();
            final TextEditingController eventTimeController = TextEditingController();

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
                  onPressed: () {
                    final eventName = eventNameController.text;
                    final eventTime = eventTimeController.text;

                    if (eventName.isEmpty || eventTime.isEmpty) {
                      // Show pop-up message for required fields
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
                      calendarData.setEventName(eventName);
                      calendarData.setEventTime(eventTime);
                      calendarData.saveEvent(context);
                    }
                  },
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
