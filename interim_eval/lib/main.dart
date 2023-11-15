import 'package:flutter/material.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
);

void main() {
  runApp(CalendarApp());
}

class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: CustomAppBar(),
        body: CalendarGrid(),
      ),
    );
  }
}

class CalendarGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define the number of rows and columns in the calendar grid.
    final int rows = 6; // 6 rows for the 6 weeks in a month
    final int columns = 7; // 7 columns for the days of the week

    // Define the start and end date for the calendar (January 2023 to January 2024).
    final DateTime startDate = DateTime(2023, 1, 1);
    final DateTime endDate = DateTime(2024, 1, 31);

    // Create a list of days within the specified date range.
    final List<DateTime> days = [];
    for (var day = startDate; day.isBefore(endDate); day = day.add(Duration(days: 1))) {
      days.add(day);
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Weekday labels
          Row(
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsPage(
                          date: day,
                        ),
                      ),
                    );
                  },
                  child: Center(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      color: staticEvent ? Color.fromARGB(255, 86, 196, 247) : null,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            Text(
                              day.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            if (staticEvent)
                              Text(
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

class EventDetailsPage extends StatefulWidget {
  final int date;

  EventDetailsPage({required this.date});

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late String eventName = '';
  late String eventTime = '';

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
              decoration: InputDecoration(
                labelText: 'Event Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  eventTime = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Event Time',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Save the event details and navigate back
                Navigator.pop(context, EventDetails(eventName: eventName, eventTime: eventTime));
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
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




class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('October 2023',style: TextStyle(fontSize: 25),),
          
           // Display "October 2023" on the left
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp), // Left arrow button
                onPressed: () {
                  // Handle left arrow button tap
                },
              ),
              Card(
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Today',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_outlined), // Right arrow button
                onPressed: () {
                  // Handle right arrow button tap
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}