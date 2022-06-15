import 'package:communicatiehelper/notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DairyPage extends StatefulWidget {
  @override
  State<DairyPage> createState() => _DairyPageState();
}

class _DairyPageState extends State<DairyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('BuildContext');
    final fragments = context.watch<FragmentChangeNotifier>().fragmentsList;
    final reversed = fragments.reversed.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alle dagboek fragmenten'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_fragment');
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: fragments.length,
        itemBuilder: (context, index) {
          final fragment = reversed[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/update_fragment',
                  arguments: fragment.id);
            },
            child: Card(
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.black,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fragment.title.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    Text(
                      fragment.description.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(fragment.created.toString().substring(0, 11)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
