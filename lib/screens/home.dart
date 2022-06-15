import 'package:flutter/material.dart';

import '../build_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thuispagina'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Cards(
                imageName: 'maps',
                name: 'Kaarten',
                routeName: '/maps',
              ),
              Cards(
                imageName: 'dairy',
                name: 'Dagboek',
                routeName: '/dairy',
              ),
              Cards(
                imageName: 'news',
                name: 'Nieuws',
                routeName: '/news',
              ),
              Cards(
                imageName: 'calendar',
                name: 'Agenda',
                routeName: '/calendar',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Cards(
                imageName: 'drawing',
                name: 'Tekenen',
                routeName: '/drawing',
              ),
              Cards(
                imageName: 'settings',
                name: 'Instellingen',
                routeName: '/settings',
              ),
              Cards(
                imageName: 'user',
                name: 'Gebruiker',
                routeName: '/user',
              ),
              Cards(
                imageName: 'symbols',
                name: 'Symbolenkaart',
                routeName: '/symbols',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Cards(
                imageName: 'camera',
                name: 'Camera',
                routeName: '/camera',
              ),
              Cards(
                imageName: 'photo',
                name: 'Foto\'s',
                routeName: '/photo',
              ),
              Cards(
                imageName: 'videocall',
                name: 'Video bellen',
                routeName: '/video',
              ),
              Cards(
                imageName: 'socialmedia',
                name: 'Sociale media',
                routeName: '/social',
              ),
            ],
          )
        ],
      ),
    );
  }
}
