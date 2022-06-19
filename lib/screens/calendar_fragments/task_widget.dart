import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communicatiehelper/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../database/event.dart';
import '../../event_data_source.dart';
import 'event_viewing_page.dart';

class TaskWidget extends StatefulWidget {
  final DateTime dateTime;
  const TaskWidget(this.dateTime, {Key? key}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  List<Event> eventToday = <Event>[];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Event>>(
      stream: getEvent(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if (snapshot.hasData) {
          var formatted = DateFormat("dd-MM-yyyy").format(widget.dateTime);
          final events = snapshot.data as List<Event>;

          for (int i = 0; i < events.length; i++) {
            var format = DateFormat("dd-MM-yyyy").format(events[i].from);
            if (formatted == format) {
              print(format);
              print(formatted);
              eventToday.add(events[i]);
            }
          }
          print(eventToday);
          return SfCalendar(
            dataSource: EventDataSource(eventToday),
            view: CalendarView.day,
            backgroundColor: Colors.white,
            onTap: (details) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EventViewingPage(
                      event: details.appointments!.first as Event)));
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Stream<List<Event>> getEvent() {
    return FirebaseFirestore.instance.collection('events').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
  }
}
