import 'package:flutter/material.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: HomePage(),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Card buildCard(String name, String naam) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          print('Clicked $name');
        },
        child: Column(
          children: [Image.asset('images/$name.png'), Text(naam)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildCard('maps', 'Kaarten'),
            buildCard('dairy', 'Dagboek'),
            buildCard('news', 'Nieuws'),
            buildCard('calendar', 'Agenda'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildCard('drawing', 'Tekenen'),
            buildCard('settings', 'Instellingen'),
            buildCard('user', 'Gebruiker'),
            buildCard('symbols', 'Symbolenkaart'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildCard('camera', 'Camera'),
            buildCard('photo', 'Foto\'s'),
            buildCard('videocall', 'Video bellen'),
            buildCard('socialmedia', 'Sociale media'),
          ],
        )
      ],
    );
  }
}
