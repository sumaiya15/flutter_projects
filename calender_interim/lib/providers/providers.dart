import 'package:flutter/material.dart';

class CalendarData extends ChangeNotifier {
  late DateTime selectedDate;
  String eventName = '';
  String eventTime = '';

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

  // Setter methods for eventName and eventTime
  void setEventName(String name) {
    eventName = name;
    notifyListeners();
  }

  void setEventTime(String time) {
    eventTime = time;
    notifyListeners();
  }

  void saveEvent(context) {
      final event = '$eventName ';
   // final event = '$eventName at $eventTime';
    addEvent(selectedDate, event);
    Navigator.pop(context, eventsData);
  }
}
