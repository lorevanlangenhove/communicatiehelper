import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communicatiehelper/event_provider.dart';
import 'package:communicatiehelper/screens/calendar_fragments/add_event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../database/event.dart';
import '../event_data_source.dart';
import 'calendar_fragments/event_viewing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late SharedPreferences prefs;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context, listen: false);

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
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            return SfCalendar(
              allowedViews: const [
                CalendarView.day,
                CalendarView.week,
                CalendarView.month
              ],
              dataSource: EventDataSource(snapshot.data),
              view: CalendarView.month,
              firstDayOfWeek: 1,
              backgroundColor: Colors.white,
              initialSelectedDate: DateTime.now(),
              onTap: (details) {
                print((details.appointments!.first as Event).title);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EventViewingPage(
                        event: details.appointments!.first as Event)));
                provider.setDate(details.date!);
              },
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
