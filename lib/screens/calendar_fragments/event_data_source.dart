import 'dart:ui';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../models/event.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title;

  @override
  Color getEventColor(int index) => getEvent(index).eventColor;

  @override
  bool getIsAllDay(int index) => getEvent(index).isAllDay;
}
