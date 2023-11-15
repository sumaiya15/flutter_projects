import 'package:calender_interim/screens/eventdetails_page.dart';
import 'package:calender_interim/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
      ),
      body: Center(
        child: Consumer<CalendarData>(
          builder: (context, calendarData, child) {
            final selectedDate = calendarData.selectedDate;
            return Column(
              children: [
                TableCalendar(
                  focusedDay: selectedDate,
                  firstDay: DateTime(2023),
                  lastDay: DateTime(2024),
                  calendarFormat: CalendarFormat.month,
                  onDaySelected: (date, dateEvents) {
                    calendarData.updateSelectedDate(date);

                    final selectedDateEvents = calendarData.eventsData[date];

                    if (selectedDateEvents != null && selectedDateEvents.isNotEmpty) {
                      // Show a snackbar message if the date already has an event
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Event is already set for this date.'),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EventDetailsPage(),
                        ),
                      );
                    }
                  },
                  selectedDayPredicate: (date) {
                    return isSameDay(date, selectedDate);
                  },
                  calendarStyle: const CalendarStyle(
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
                      final eventList = calendarData.eventsData[date] ?? [];

                      return Column(
                        children: eventList
                            .map((event) => Text(
                                  event,
                                  style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 243, 16, 92)),
                                ))
                            .toList(),
                      );
                    },
                  ),
                  onFormatChanged: (format) {
                    // Handle the calendar format change here.
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
