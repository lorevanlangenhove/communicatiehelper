import 'package:communicatiehelper/screens/calendar.dart';
import 'package:communicatiehelper/screens/camera.dart';
import 'package:communicatiehelper/screens/dairy.dart';
import 'package:communicatiehelper/screens/drawing.dart';
import 'package:communicatiehelper/screens/news.dart';
import 'package:communicatiehelper/screens/photo.dart';
import 'package:communicatiehelper/screens/settings.dart';
import 'package:communicatiehelper/screens/social.dart';
import 'package:communicatiehelper/screens/symbols.dart';
import 'package:communicatiehelper/screens/user.dart';
import 'package:communicatiehelper/screens/video.dart';
import 'package:flutter/material.dart';
import 'build_card.dart';
import '../screens/maps.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/maps': (context) => MapsPage(),
        '/dairy': (context) => DairyPage(),
        '/news': (context) => NewsPage(),
        '/calendar': (context) => CalendarPage(),
        '/drawing': (context) => DrawingPage(),
        '/settings': (context) => SettingsPage(),
        '/user': (context) => UserssPage(),
        '/symbols': (context) => SymbolsPage(),
        '/camera': (context) => CameraPage(),
        '/photo': (context) => PhotosPage(),
        '/video': (context) => VideosPage(),
        '/social': (context) => SocialsPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
