import 'dart:io';
import 'package:communicatiehelper/database/dairy_entity.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'dairy.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Dairy])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<DairyData>> getAllFragments() async {
    return await select(dairy).get();
  }

  Future<DairyData> getFragment(int id) async {
    return await (select(dairy)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<bool> updateFragment(DairyCompanion entity) async {
    return await update(dairy).replace(entity);
  }

  Future<int> insertFragment(DairyCompanion entity) async {
    return await into(dairy).insert(entity);
  }

  Future<int> deleteFragment(int id) async {
    return await (delete(dairy)..where((tbl) => tbl.id.equals(id))).go();
  }
}
