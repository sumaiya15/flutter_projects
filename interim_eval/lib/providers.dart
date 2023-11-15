import 'package:flutter/foundation.dart';
//import 'package:table_calendar/table_calendar.dart';

class CalendarData extends ChangeNotifier {
  late DateTime selectedDate;

  // A map to store event data for each date.
  Map<DateTime, List<String>> eventsData = {};

  CalendarData() {
    selectedDate = DateTime.now();
  }

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void addEvent(DateTime date, String event) {
    if (!eventsData.containsKey(date)) {
      eventsData[date] = [];
    }
    eventsData[date]!.add(event);
    notifyListeners();
  }
}
