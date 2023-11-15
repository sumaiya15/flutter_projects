import 'package:flutter/material.dart';
import 'package:interim_eval/eventdetails_page.dart';
import 'package:interim_eval/providers.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendarData = Provider.of<CalendarData>(context);
    final selectedDate = calendarData.selectedDate; // Added this line

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
      ),
      body: Center(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: calendarData.selectedDate,
              firstDay: DateTime(2023),
              lastDay: DateTime(2024),
              calendarFormat: CalendarFormat.month,
              onDaySelected: (date, dateEvents) {
                calendarData.updateSelectedDate(date);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EventDetailsPage(),
                  ),
                );
              },
              selectedDayPredicate: (date) {
                return isSameDay(date, selectedDate); // Used selectedDate here
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
                  final eventList = calendarData.eventsData[date] ?? []; // Updated this line

                  return Column(
                    children: eventList
                        .map((event) => Text(
                              event,
                              style:const  TextStyle(fontSize: 12, color: Colors.pink),
                            ))
                        .toList(),
                  );
                },
              ),
              onFormatChanged: (format) {
                // Handle the calendar format change here.
                // You can update your UI or perform any necessary actions.
              },
              // ... (rest of your TableCalendar code)
            ),
          ],
        ),
      ),
    );
  }
}
