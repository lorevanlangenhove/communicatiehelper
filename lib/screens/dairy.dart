import 'package:communicatiehelper/database/db.dart';
import 'package:communicatiehelper/screens/dairy_fragments/add_dairy_fragment.dart';
import 'package:flutter/material.dart';

class DairyPage extends StatefulWidget {
  static String id = 'dairy_page';

  @override
  State<DairyPage> createState() => _DairyPageState();
}

class _DairyPageState extends State<DairyPage> {
  late AppDb _db;
  @override
  void initState() {
    super.initState();
    _db = AppDb();
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddDairyFragment.id);
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<List<DairyData>>(
        future: _db.getAllFragments(),
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
                    onTap: () {},
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
