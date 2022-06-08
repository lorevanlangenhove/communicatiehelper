import 'package:communicatiehelper/screens/calendar.dart';
import 'package:communicatiehelper/screens/camera.dart';
import 'package:communicatiehelper/screens/dairy.dart';
import 'package:communicatiehelper/screens/dairy_fragments/add_dairy_fragment.dart';
import 'package:communicatiehelper/screens/dairy_fragments/fragment.dart';
import 'package:communicatiehelper/screens/dairy_fragments/update_dairy_fragment.dart';
import 'package:communicatiehelper/screens/drawing.dart';
import 'package:communicatiehelper/screens/home.dart';
import 'package:communicatiehelper/screens/maps.dart';
import 'package:communicatiehelper/screens/news.dart';
import 'package:communicatiehelper/screens/photo.dart';
import 'package:communicatiehelper/screens/settings.dart';
import 'package:communicatiehelper/screens/social.dart';
import 'package:communicatiehelper/screens/symbols.dart';
import 'package:communicatiehelper/screens/user.dart';
import 'package:communicatiehelper/screens/video.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/calendar':
        return MaterialPageRoute(builder: (_) => CalendarPage());
      case '/camera':
        return MaterialPageRoute(builder: (_) => CameraPage());
      case '/dairy':
        return MaterialPageRoute(builder: (_) => DairyPage());
      case '/add_fragment':
        return MaterialPageRoute(builder: (_) => AddDairyFragment());
      case '/update_fragment':
        if (args is int) {
          return MaterialPageRoute(
              builder: (_) => UpdateDairyFragment(id: args));
        }
        return _errorRoute();
      case '/fragment':
        if (args is int) {
          return MaterialPageRoute(builder: (_) => Fragment(id: args));
        }
        return _errorRoute();
      case '/drawing':
        return MaterialPageRoute(builder: (_) => DrawingPage());
      case '/maps':
        return MaterialPageRoute(builder: (_) => MapsPage());
      case '/news':
        return MaterialPageRoute(builder: (_) => NewsPage());
      case '/photo':
        return MaterialPageRoute(builder: (_) => PhotosPage());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/social':
        return MaterialPageRoute(builder: (_) => SocialsPage());
      case '/symbols':
        return MaterialPageRoute(builder: (_) => SymbolsPage());
      case '/user':
        return MaterialPageRoute(builder: (_) => UserssPage());
      case '/video':
        return MaterialPageRoute(builder: (_) => VideosPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Deze pagina bestaat niet'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Sorry, deze pagina bestaat niet',
            style: TextStyle(color: Colors.red, fontSize: 18.0),
          ),
        ),
      );
    });
  }
}
