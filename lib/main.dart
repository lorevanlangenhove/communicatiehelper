import 'package:communicatiehelper/database/db.dart';
import 'package:communicatiehelper/event_provider.dart';
import 'package:communicatiehelper/notifier.dart';
import 'package:communicatiehelper/route_generator.dart';
import 'package:communicatiehelper/screens/maps_fragment/application_block.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider.value(value: AppDb()),
      ChangeNotifierProxyProvider<AppDb, FragmentChangeNotifier>(
          create: (context) => FragmentChangeNotifier(),
          update: (context, db, notifier) => notifier!
            ..initAppDb(db)
            ..getFragments()),
      ChangeNotifierProvider(create: (context) => EventProvider()),
      ChangeNotifierProvider(create: (context) => ApplicationBlock()),
    ],
    child: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: [Locale('nl')],
      locale: Locale('nl'),
      color: Colors.white,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
