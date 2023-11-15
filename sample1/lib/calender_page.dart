import 'package:flutter/material.dart';
import 'package:sample1/EventDetails_Page.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime selectedDate;

  // A map to store event data for each date.
  Map<DateTime, List<String>> eventsData = {};

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
      ),
      body: Center(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: selectedDate,
              firstDay: DateTime(2023),
              lastDay: DateTime(2024),
              calendarFormat: CalendarFormat.month,
              onDaySelected: (date, dateEvents) {
                setState(() {
                  selectedDate = date;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsPage(
                      selectedDate: date,
                      eventsData: eventsData,
                    ),
                  ),
                ).then((result) {
                  if (result != null && result is Map<DateTime, List<String>>) {
                    // Handle the result from the EventDetailsPage and update the eventsData.
                    setState(() {
                      eventsData = result;
                    });
                  }
                });
              },
              selectedDayPredicate: (date) {
                return isSameDay(date, selectedDate);
              },
              calendarStyle:const  CalendarStyle(
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                todayTextStyle: TextStyle(color: Colors.white),
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  final eventList = eventsData[date] ?? [];

                  return Column(
                    children: eventList
                        .map((event) => Text(
                              event,
                              style: const TextStyle(fontSize: 12, color: Colors.pink),
                            ))
                        .toList(),
                  );
                },
              ),
              onFormatChanged: (format) {
                // Handle the calendar format change here.
                // You can update your UI or perform any necessary actions.
              },
            ),
          ],
        ),
      ),
    );
  }
}
