import 'package:drift/drift.dart';

class Dairy extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().named('title')();
  TextColumn get description => text().named('description')();
  DateTimeColumn get created => dateTime().withDefault(currentDateAndTime)();
}
