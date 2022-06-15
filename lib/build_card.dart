import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  Cards({required this.imageName, required this.name, required this.routeName});

  final String imageName;
  final String name;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Card(
        child: InkWell(
          splashColor: Colors.blue,
          child: Column(
            children: [
              Image.asset('images/$imageName.png'),
              Text(
                name,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
