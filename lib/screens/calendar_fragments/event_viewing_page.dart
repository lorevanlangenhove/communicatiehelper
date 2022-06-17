import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communicatiehelper/database/event.dart';
import 'package:communicatiehelper/screens/calendar_fragments/update_event.dart';
import 'package:communicatiehelper/utils.dart';
import 'package:flutter/material.dart';

class EventViewingPage extends StatefulWidget {
  final Event event;

  const EventViewingPage({Key? key, required this.event}) : super(key: key);

  @override
  State<EventViewingPage> createState() => _EventViewingPageState();
}

class _EventViewingPageState extends State<EventViewingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Afspraak'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => UpdateEvent(event: widget.event)));
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              deleteEvent();
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<Event?>(
        future: readEvent(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Er is iets misgelopen! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final event = snapshot.data;
            return event == null
                ? const Center(
                    child: Text('Er zijn geen afspraken'),
                  )
                : buildEvent(event);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildEvent(Event event) => Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              event.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              event.description,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    'VAN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    Utils.toDate(event.from),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    Utils.toTime(event.from),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    'TOT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    Utils.toDate(event.to),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    Utils.toTime(event.to),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      );

  Future<Event?> readEvent() async {
    final docEvent =
        FirebaseFirestore.instance.collection('events').doc(widget.event.id);
    final snapshot = await docEvent.get();

    if (snapshot.exists) {
      return Event.fromJson(snapshot.data()!);
    }
  }

  Future<void> deleteEvent() async {
    return await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.event.id)
        .delete();
  }
}
