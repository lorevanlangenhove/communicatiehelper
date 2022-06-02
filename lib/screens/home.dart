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
  static String id = 'home_page';

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
              routeName: MapsPage.id,
            ),
            Cards(
              imageName: 'dairy',
              name: 'Dagboek',
              routeName: DairyPage.id,
            ),
            Cards(
              imageName: 'news',
              name: 'Nieuws',
              routeName: NewsPage.id,
            ),
            Cards(
              imageName: 'calendar',
              name: 'Agenda',
              routeName: CalendarPage.id,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Cards(
              imageName: 'drawing',
              name: 'Tekenen',
              routeName: DrawingPage.id,
            ),
            Cards(
              imageName: 'settings',
              name: 'Instellingen',
              routeName: SettingsPage.id,
            ),
            Cards(
              imageName: 'user',
              name: 'Gebruiker',
              routeName: UserssPage.id,
            ),
            Cards(
              imageName: 'symbols',
              name: 'Symbolenkaart',
              routeName: SymbolsPage.id,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Cards(
              imageName: 'camera',
              name: 'Camera',
              routeName: CameraPage.id,
            ),
            Cards(
              imageName: 'photo',
              name: 'Foto\'s',
              routeName: PhotosPage.id,
            ),
            Cards(
              imageName: 'videocall',
              name: 'Video bellen',
              routeName: VideosPage.id,
            ),
            Cards(
              imageName: 'socialmedia',
              name: 'Sociale media',
              routeName: SocialsPage.id,
            ),
          ],
        )
      ],
    );
  }
}
