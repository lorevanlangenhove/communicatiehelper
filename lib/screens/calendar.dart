import 'package:communicatiehelper/event_provider.dart';
import 'package:communicatiehelper/screens/calendar_fragments/add_event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../event_data_source.dart';
import 'calendar_fragments/tasks_widget.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

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
      body: SfCalendar(
        dataSource: EventDataSource(events),
        view: CalendarView.month,
        backgroundColor: Colors.white,
        initialSelectedDate: DateTime.now(),
        onLongPress: (details) {
          final provider = Provider.of<EventProvider>(context, listen: false);
          provider.setDate(details.date!);
          showModalBottomSheet(
              context: context, builder: (context) => TasksWidget());
        },
      ),
    );
  }
}
