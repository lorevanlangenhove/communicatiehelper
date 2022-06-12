import 'package:communicatiehelper/database/db.dart';
import 'package:communicatiehelper/event_provider.dart';
import 'package:communicatiehelper/notifier.dart';
import 'package:communicatiehelper/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider.value(value: AppDb()),
      ChangeNotifierProxyProvider<AppDb, FragmentChangeNotifier>(
          create: (context) => FragmentChangeNotifier(),
          update: (context, db, notifier) => notifier!
            ..initAppDb(db)
            ..getFragments()),
      ChangeNotifierProvider(create: (context) => EventProvider())
    ],
    child: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      locale: Locale('nl'),
      color: Colors.white,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
