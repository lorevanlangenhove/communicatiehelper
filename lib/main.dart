import 'package:communicatiehelper/database/db.dart';
import 'package:communicatiehelper/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Provider(
    create: (context) => AppDb(),
    child: Home(),
    dispose: (context, AppDb db) => db.close(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: Colors.white,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
