import 'package:flutter/material.dart';

class CalendarData with ChangeNotifier {
  final Map<DateTime, List<String>> eventDataMap = {};

  Map<DateTime, List<String>> get data => eventDataMap;

  void addData(DateTime date, String eventName) {
    if (!eventDataMap.containsKey(date)) {
      eventDataMap[date] = [];
    }
    eventDataMap[date]!.add(eventName);
    notifyListeners();
  }

  List<String> getEventNamesForDate(DateTime date) {
    return eventDataMap[date] ?? [];
  }
  void updateEventName(DateTime date, int index, String editedEvent) {
  if (eventDataMap.containsKey(date) && index >= 0 && index < eventDataMap[date]!.length) {
    eventDataMap[date]![index] = editedEvent;
    notifyListeners();
  }
}

}
