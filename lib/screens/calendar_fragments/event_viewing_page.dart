import 'package:communicatiehelper/database/event.dart';
import 'package:communicatiehelper/screens/calendar_fragments/add_event.dart';
import 'package:communicatiehelper/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../event_provider.dart';

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
                  builder: (context) => AddEvent(event: widget.event)));
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              final provider =
                  Provider.of<EventProvider>(context, listen: false);
              provider.deleteEvent(widget.event);
              Navigator.pop(context);
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
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              widget.event.title,
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
              widget.event.description,
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
                    Utils.toDate(widget.event.from),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    Utils.toTime(widget.event.from),
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
                    Utils.toDate(widget.event.to),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    Utils.toTime(widget.event.to),
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
      ),
    );
  }
}
