import 'package:flutter/cupertino.dart';
import 'database/event.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];

  List<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events;

  void deleteEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }
}
