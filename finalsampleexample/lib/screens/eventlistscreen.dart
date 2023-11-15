import 'package:finalsampleexample/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventListScreen extends StatelessWidget {
  final List<String> eventNames;
  final DateTime currentDate;

  const EventListScreen(this.eventNames, this.currentDate, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController editedEventController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer<CalendarData>(
              builder: (context, calendarData, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: eventNames.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(eventNames[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Edit Event'),
                                content: TextField(
                                  controller: editedEventController,
                                  decoration: const InputDecoration(
                                    hintText: 'Edit Event Name',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      final editedEvent = editedEventController.text;
                                      if (editedEvent.isNotEmpty) {
                                        // Use the CalendarData provider to update the event data.
                                        calendarData.updateEventName(currentDate, index, editedEvent);
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous screen when done editing.
                Navigator.of(context).pop();
              },
              child: const Text('Done Editing'),
            ),
          ],
        ),
      ),
    );
  }
}
