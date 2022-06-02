// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class DairyData extends DataClass implements Insertable<DairyData> {
  final int id;
  final String title;
  final String description;
  final DateTime created;
  DairyData(
      {required this.id,
      required this.title,
      required this.description,
      required this.created});
  factory DairyData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DairyData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      created: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['created'] = Variable<DateTime>(created);
    return map;
  }

  DairyCompanion toCompanion(bool nullToAbsent) {
    return DairyCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      created: Value(created),
    );
  }

  factory DairyData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DairyData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      created: serializer.fromJson<DateTime>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'created': serializer.toJson<DateTime>(created),
    };
  }

  DairyData copyWith(
          {int? id, String? title, String? description, DateTime? created}) =>
      DairyData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        created: created ?? this.created,
      );
  @override
  String toString() {
    return (StringBuffer('DairyData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, created);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DairyData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.created == this.created);
}

class DairyCompanion extends UpdateCompanion<DairyData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> created;
  const DairyCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.created = const Value.absent(),
  });
  DairyCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    this.created = const Value.absent(),
  })  : title = Value(title),
        description = Value(description);
  static Insertable<DairyData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? created,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (created != null) 'created': created,
    });
  }

  DairyCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? description,
      Value<DateTime>? created}) {
    return DairyCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      created: created ?? this.created,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DairyCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }
}

class $DairyTable extends Dairy with TableInfo<$DairyTable, DairyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DairyTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _createdMeta = const VerificationMeta('created');
  @override
  late final GeneratedColumn<DateTime?> created = GeneratedColumn<DateTime?>(
      'created', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, title, description, created];
  @override
  String get aliasedName => _alias ?? 'dairy';
  @override
  String get actualTableName => 'dairy';
  @override
  VerificationContext validateIntegrity(Insertable<DairyData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created']!, _createdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DairyData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DairyData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DairyTable createAlias(String alias) {
    return $DairyTable(attachedDatabase, alias);
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $DairyTable dairy = $DairyTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dairy];
}
