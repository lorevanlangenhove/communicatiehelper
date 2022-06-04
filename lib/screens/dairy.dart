import 'package:communicatiehelper/database/db.dart';
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
      body: FutureBuilder<List<DairyData>>(
        future: Provider.of<AppDb>(context, listen: false).getAllFragments(),
        builder: (context, snapshot) {
          final List<DairyData>? fragments = snapshot.data;
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (fragments != null) {
            return ListView.builder(
                itemCount: fragments.length,
                itemBuilder: (context, index) {
                  final fragment = fragments[index];
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
                              fragment.id.toString(),
                            ),
                            Text(
                              fragment.title.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 20),
                            ),
                            Text(
                              fragment.description.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(fragment.created.toString()),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return const Text('Er zijn geen dagboekfragmenten');
        },
      ),
    );
  }
}
