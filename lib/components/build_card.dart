import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  Cards({required this.imageName, required this.name});

  final String imageName;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue,
        child: Column(
          children: [
            Image.asset('images/$imageName.png'),
            Text(
              name,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
