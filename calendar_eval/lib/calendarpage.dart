import 'package:calendar_eval/eventdetaillist.dart';
import 'package:flutter/material.dart';

class CalendarGrid extends StatefulWidget {
  const CalendarGrid({super.key});

  @override
  State<CalendarGrid> createState() => _CalendarGridState();
}

class _CalendarGridState extends State<CalendarGrid> {

  late DateTime selectedDate; // Add this field to store the selected date
  String? eventForSelectedDate; // Add this field to store the event name

   @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    const int rows = 6; 
    const int columns = 7;

    final DateTime startDate = DateTime(2023, 1, 1);
    final DateTime endDate = DateTime(2024, 1, 31);

    // Create a list of days within the specified date range.
    final List<DateTime> days = [];
    for (var day = startDate; day.isBefore(endDate); 
      day = day.add(const Duration(days: 1))) {
      days.add(day);
    }

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
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              childAspectRatio: 1.0,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
            ),
            itemCount: rows * columns,
            itemBuilder: (context, index) {
              // Calculate the day number for the cell.
              if (index < days.length) {
                final day = days[index].day;
                bool staticEvent = (day == 25);
                return GestureDetector(
                  onTap: () {
            setState(() {
              selectedDate = DateTime(selectedDate.year, selectedDate.month, day);
            });
                    Navigator.push(
                      context,
  MaterialPageRoute(
    builder: (context) => EventDetailsPage(
      date: day,
    ),
  ),
).then((value) {
  if (value != null && value is EventDetails) {
    // Update the selected date and event name if an event was saved
    setState(() {
      //selectedDate = value.selectedDate;
      eventForSelectedDate = value.eventName;
    });
  }
});
                  },
                  child: Center(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      color: staticEvent ? const Color.fromARGB(255, 86, 196, 247) : null,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            Text(
                              day.toString(),
                              style:const  TextStyle(fontSize: 18),
                            ),
                            if (staticEvent)
                             const Text(
                                'Party',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 236, 43, 69),
                                  fontWeight: FontWeight.bold,
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
          ),
        ],
      ),
    );
  }
}