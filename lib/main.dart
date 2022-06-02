import 'package:communicatiehelper/screens/calendar.dart';
import 'package:communicatiehelper/screens/camera.dart';
import 'package:communicatiehelper/screens/dairy.dart';
import 'package:communicatiehelper/screens/drawing.dart';
import 'package:communicatiehelper/screens/home.dart';
import 'package:communicatiehelper/screens/news.dart';
import 'package:communicatiehelper/screens/photo.dart';
import 'package:communicatiehelper/screens/settings.dart';
import 'package:communicatiehelper/screens/social.dart';
import 'package:communicatiehelper/screens/symbols.dart';
import 'package:communicatiehelper/screens/user.dart';
import 'package:communicatiehelper/screens/video.dart';
import 'package:flutter/material.dart';
import '../screens/maps.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        MapsPage.id: (context) => MapsPage(),
        DairyPage.id: (context) => DairyPage(),
        NewsPage.id: (context) => NewsPage(),
        CalendarPage.id: (context) => CalendarPage(),
        DrawingPage.id: (context) => DrawingPage(),
        SettingsPage.id: (context) => SettingsPage(),
        UserssPage.id: (context) => UserssPage(),
        SymbolsPage.id: (context) => SymbolsPage(),
        CameraPage.id: (context) => CameraPage(),
        PhotosPage.id: (context) => PhotosPage(),
        VideosPage.id: (context) => VideosPage(),
        SocialsPage.id: (context) => SocialsPage(),
      },
    );
  }
}
