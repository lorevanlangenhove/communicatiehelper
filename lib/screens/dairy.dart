import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communicatiehelper/database/fragment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dairy_fragments/add_dairy_fragment.dart';
import 'dairy_fragments/view_fragment.dart';

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
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddDairyFragment()));
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<List<Fragment>>(
        stream: readFragments(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Er is iets misgegaan! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final fragments = snapshot.data!;
            final reversed = fragments.reversed.toList();

            return ListView(
              children: reversed.map(buildFragment).toList(),
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

  Widget buildFragment(Fragment fragment) {
    var formatted = DateFormat("dd-MM-yyyy").format(fragment.created);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewFragment(fragment: fragment)));
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
                style:
                    const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
              Text(
                fragment.description.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              Text(formatted),
            ],
          ),
        ),
      ),
    );
  }

  Stream<List<Fragment>> readFragments() => FirebaseFirestore.instance
      .collection('fragments')
      .orderBy('created')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Fragment.fromJson(doc.data())).toList());
}
