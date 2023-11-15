import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalsampleexample/provider/provider.dart';
import 'package:finalsampleexample/screens/eventinputscreen.dart';
import 'package:finalsampleexample/screens/eventlistscreen.dart';

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({super.key});

  // Function to check if a date is in January
  bool isDateInJanuary(DateTime date) {
    return date.month == DateTime.january;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Weekday labels
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Sun'),
              Text('Mon'),
              Text('Tue'),
              Text('Wed'),
              Text('Thu'),
              Text('Fri'),
              Text('Sat'),
            ],
          ),
          // Calendar grid
          Consumer<CalendarData>(
            builder: (context, calendarData, _) {
              const int rows = 6;
              const int columns = 7;
              final DateTime startDate = DateTime(2023, 1, 1);
              final DateTime endDate = DateTime(2024, 1, 31);
              final List<DateTime> days = [];

              for (var day = startDate; day.isBefore(endDate); day = day.add(const Duration(days: 1))) {
                days.add(day);
              }

              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                ),
                itemCount: rows * columns,
                itemBuilder: (context, index) {
                  if (index < days.length) {
                    final day = days[index].day;
                    final currentDate = days[index];
                    final eventNames = calendarData.getEventNamesForDate(currentDate);

                    // Determine if the date is in January
                    final isJanuary = isDateInJanuary(currentDate);

                    // Check if it's the 25th day and if a custom event name is available
                    String eventName = currentDate.day == 25 && isJanuary
                        ? 'Party' // Default event name
                        : ''; // Empty string for other days

                    if (eventNames.isNotEmpty) {
                      eventName = eventNames.join('\n');
                    }

                    // Define the text color for the event name based on the condition
                    Color eventNameColor = Colors.grey; // Default color
                    if (eventNames.isNotEmpty) {
                      eventNameColor = Colors.pink;
                    } else if (currentDate.day == 25 && isJanuary) {
                      eventNameColor = const Color.fromARGB(255, 20, 98, 214);
                    }
                    return Center(
                      child: Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 155, 151, 151),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            if (eventNames.isNotEmpty) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EventListScreen(eventNames, currentDate),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EventDetailsPage(currentDate),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: 120,
                            height: 80,
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                Text(
                                  day.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: isJanuary ? Colors.black : Colors.grey, // Change date text color
                                  ),
                                ),
                                Text(
                                  eventName, // Use the determined event name
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: eventNameColor, // Change event name text color
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
