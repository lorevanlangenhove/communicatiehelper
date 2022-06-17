import 'package:communicatiehelper/screens/calendar.dart';
import 'package:communicatiehelper/screens/camera.dart';
import 'package:communicatiehelper/screens/dairy.dart';
import 'package:communicatiehelper/screens/drawing.dart';
import 'package:communicatiehelper/screens/maps.dart';
import 'package:communicatiehelper/screens/news.dart';
import 'package:communicatiehelper/screens/photo.dart';
import 'package:communicatiehelper/screens/settings.dart';
import 'package:communicatiehelper/screens/social.dart';
import 'package:communicatiehelper/screens/symbols.dart';
import 'package:communicatiehelper/screens/user.dart';
import 'package:communicatiehelper/screens/video.dart';
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MapsPage()));
                },
                child: Cards(
                  imageName: 'maps',
                  name: 'Kaarten',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DairyPage()));
                },
                child: Cards(
                  imageName: 'dairy',
                  name: 'Dagboek',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NewsPage()));
                },
                child: Cards(
                  imageName: 'news',
                  name: 'Nieuws',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CalendarPage()));
                },
                child: Cards(
                  imageName: 'calendar',
                  name: 'Kalender',
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DrawingPage()));
                },
                child: Cards(
                  imageName: 'drawing',
                  name: 'Tekenen',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
                child: Cards(
                  imageName: 'settings',
                  name: 'Instellingen',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserssPage()));
                },
                child: Cards(
                  imageName: 'user',
                  name: 'Gebruiker',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SymbolsPage()));
                },
                child: Cards(
                  imageName: 'symbols',
                  name: 'Symbolenkaart',
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CameraPage()));
                },
                child: Cards(
                  imageName: 'camera',
                  name: 'Camera',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PhotosPage()));
                },
                child: Cards(
                  imageName: 'photo',
                  name: 'Foto\'s',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => VideosPage()));
                },
                child: Cards(
                  imageName: 'videocall',
                  name: 'Video bellen',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SocialsPage()));
                },
                child: Cards(
                  imageName: 'socialmedia',
                  name: 'Sociale media',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
