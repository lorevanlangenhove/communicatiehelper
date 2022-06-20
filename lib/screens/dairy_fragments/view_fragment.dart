import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/fragment.dart';
import 'package:communicatiehelper/screens/dairy_fragments/update_dairy_fragment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewFragment extends StatefulWidget {
  final Fragment fragment;

  const ViewFragment({Key? key, required this.fragment}) : super(key: key);

  @override
  State<ViewFragment> createState() => _ViewFragment();
}

class _ViewFragment extends State<ViewFragment> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Een dagboek fragment'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      UpdateDairyFragment(fragment: widget.fragment)));
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              deleteFragment();
            },
            icon: const Icon(Icons.delete),
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
      body: FutureBuilder<Fragment?>(
          future: readFragment(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Er is iets misgelopen! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final fragment = snapshot.data;
              return fragment == null
                  ? const Center(
                      child: Text('Er zijn geen afspraken'),
                    )
                  : buildFragment(fragment);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildFragment(Fragment fragment) {
    var formatted = DateFormat("dd-MM-yyyy").format(fragment.created);
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            fragment.title,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 40.0),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          fragment.description,
          style: const TextStyle(fontSize: 40.0),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          formatted,
          style: const TextStyle(fontSize: 40.0),
        ),
      ],
    );
  }

  Future<Fragment?> readFragment() async {
    final docEvent = FirebaseFirestore.instance
        .collection('fragments')
        .doc(widget.fragment.id);
    final snapshot = await docEvent.get();

    if (snapshot.exists) {
      return Fragment.fromJson(snapshot.data()!);
    }
  }

  Future<void> deleteFragment() async {
    return await FirebaseFirestore.instance
        .collection('fragments')
        .doc(widget.fragment.id)
        .delete()
        .then(
          (value) => ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              backgroundColor: Colors.red,
              content: const Text(
                'Dagboek fragment is verwijdert',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  },
                  child: const Text(
                    'Sluit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
