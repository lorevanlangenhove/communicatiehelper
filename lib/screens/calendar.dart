import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communicatiehelper/screens/calendar_fragments/add_event.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../models/event.dart';
import 'calendar_fragments/event_data_source.dart';
import 'calendar_fragments/event_viewing_page.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarController _controller = CalendarController();
  @override
  Widget build(BuildContext context) {
    final theme = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? true
        : false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalender'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddEvent()));
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<List<Event>>(
        stream: getEvent(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Er is iets misgelopen! ${snapshot.error}');
          } else if (snapshot.hasData) {
            if (theme) {
              return SfCalendarTheme(
                data: SfCalendarThemeData(
                    agendaBackgroundColor: Colors.black,
                    backgroundColor: Colors.black,
                    brightness: Brightness.dark,
                    agendaDateTextStyle: const TextStyle(color: Colors.white)),
                child: SfCalendar(
                  controller: _controller,
                  allowedViews: const [
                    CalendarView.day,
                    CalendarView.week,
                    CalendarView.month
                  ],
                  dataSource: EventDataSource(snapshot.data),
                  view: CalendarView.week,
                  firstDayOfWeek: 1,
                  initialSelectedDate: DateTime.now(),
                  onTap: (details) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EventViewingPage(
                            event: details.appointments!.first as Event)));
                  },
                ),
              );
            } else if (!theme) {
              return SfCalendar(
                controller: _controller,
                allowedViews: const [
                  CalendarView.day,
                  CalendarView.week,
                  CalendarView.month
                ],
                dataSource: EventDataSource(snapshot.data),
                view: CalendarView.week,
                firstDayOfWeek: 1,
                backgroundColor: Colors.white,
                initialSelectedDate: DateTime.now(),
                onTap: (details) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EventViewingPage(
                          event: details.appointments!.first as Event)));
                },
              );
            }
            return const Center(
              child: Text('Er zijn geen afspraken'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Stream<List<Event>> getEvent() {
    return FirebaseFirestore.instance.collection('events').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
  }
}
