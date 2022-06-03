import 'package:communicatiehelper/screens/add_dairy_fragment.dart';
import 'package:flutter/material.dart';

class DairyPage extends StatelessWidget {
  static String id = 'dairy_page';

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
    );
  }
}
