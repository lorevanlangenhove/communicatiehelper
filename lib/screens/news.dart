import 'package:communicatiehelper/database/event.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
        ),
        actions: [
          IconButton(
              onPressed: () {
                final title = controller.text;
                createEvent(title: title);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder<List<Event>>(
        stream: readEvent(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final events = snapshot.data!;

            return ListView(
              children: events.map(buildEvent).toList(),
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

  Widget buildEvent(Event event) => ListTile(
        title: Text(event.title),
        subtitle: Text(DateFormat("dd-MM-yyyy").format(event.from)),
      );

  Future createEvent({required String title}) async {
    final docEvent = FirebaseFirestore.instance.collection('events').doc();
    final event = Event(
        id: docEvent.id,
        title: title,
        description: 'description',
        from: DateTime.now(),
        to: DateTime.now().add(const Duration(hours: 2)));

    final json = event.toJson();

    await docEvent.set(json);
  }

  Stream<List<Event>> readEvent() => FirebaseFirestore.instance
      .collection('events')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());
}
