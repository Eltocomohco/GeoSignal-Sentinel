// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PositionTableTable extends PositionTable
    with TableInfo<$PositionTableTable, PositionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PositionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta(
    'accuracy',
  );
  @override
  late final GeneratedColumn<double> accuracy = GeneratedColumn<double>(
    'accuracy',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _altitudeMeta = const VerificationMeta(
    'altitude',
  );
  @override
  late final GeneratedColumn<double> altitude = GeneratedColumn<double>(
    'altitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _headingMeta = const VerificationMeta(
    'heading',
  );
  @override
  late final GeneratedColumn<double> heading = GeneratedColumn<double>(
    'heading',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<double> speed = GeneratedColumn<double>(
    'speed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isMockedMeta = const VerificationMeta(
    'isMocked',
  );
  @override
  late final GeneratedColumn<bool> isMocked = GeneratedColumn<bool>(
    'is_mocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_mocked" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    latitude,
    longitude,
    accuracy,
    altitude,
    heading,
    speed,
    timestamp,
    provider,
    isMocked,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'position_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PositionTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('accuracy')) {
      context.handle(
        _accuracyMeta,
        accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta),
      );
    } else if (isInserting) {
      context.missing(_accuracyMeta);
    }
    if (data.containsKey('altitude')) {
      context.handle(
        _altitudeMeta,
        altitude.isAcceptableOrUnknown(data['altitude']!, _altitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_altitudeMeta);
    }
    if (data.containsKey('heading')) {
      context.handle(
        _headingMeta,
        heading.isAcceptableOrUnknown(data['heading']!, _headingMeta),
      );
    } else if (isInserting) {
      context.missing(_headingMeta);
    }
    if (data.containsKey('speed')) {
      context.handle(
        _speedMeta,
        speed.isAcceptableOrUnknown(data['speed']!, _speedMeta),
      );
    } else if (isInserting) {
      context.missing(_speedMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('is_mocked')) {
      context.handle(
        _isMockedMeta,
        isMocked.isAcceptableOrUnknown(data['is_mocked']!, _isMockedMeta),
      );
    } else if (isInserting) {
      context.missing(_isMockedMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PositionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PositionTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      accuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy'],
      )!,
      altitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altitude'],
      )!,
      heading: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}heading'],
      )!,
      speed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      )!,
      isMocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_mocked'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $PositionTableTable createAlias(String alias) {
    return $PositionTableTable(attachedDatabase, alias);
  }
}

class PositionTableData extends DataClass
    implements Insertable<PositionTableData> {
  final int id;
  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double heading;
  final double speed;
  final DateTime timestamp;
  final String provider;
  final bool isMocked;
  final bool isSynced;
  const PositionTableData({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.altitude,
    required this.heading,
    required this.speed,
    required this.timestamp,
    required this.provider,
    required this.isMocked,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['accuracy'] = Variable<double>(accuracy);
    map['altitude'] = Variable<double>(altitude);
    map['heading'] = Variable<double>(heading);
    map['speed'] = Variable<double>(speed);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['provider'] = Variable<String>(provider);
    map['is_mocked'] = Variable<bool>(isMocked);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  PositionTableCompanion toCompanion(bool nullToAbsent) {
    return PositionTableCompanion(
      id: Value(id),
      latitude: Value(latitude),
      longitude: Value(longitude),
      accuracy: Value(accuracy),
      altitude: Value(altitude),
      heading: Value(heading),
      speed: Value(speed),
      timestamp: Value(timestamp),
      provider: Value(provider),
      isMocked: Value(isMocked),
      isSynced: Value(isSynced),
    );
  }

  factory PositionTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PositionTableData(
      id: serializer.fromJson<int>(json['id']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      accuracy: serializer.fromJson<double>(json['accuracy']),
      altitude: serializer.fromJson<double>(json['altitude']),
      heading: serializer.fromJson<double>(json['heading']),
      speed: serializer.fromJson<double>(json['speed']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      provider: serializer.fromJson<String>(json['provider']),
      isMocked: serializer.fromJson<bool>(json['isMocked']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'accuracy': serializer.toJson<double>(accuracy),
      'altitude': serializer.toJson<double>(altitude),
      'heading': serializer.toJson<double>(heading),
      'speed': serializer.toJson<double>(speed),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'provider': serializer.toJson<String>(provider),
      'isMocked': serializer.toJson<bool>(isMocked),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  PositionTableData copyWith({
    int? id,
    double? latitude,
    double? longitude,
    double? accuracy,
    double? altitude,
    double? heading,
    double? speed,
    DateTime? timestamp,
    String? provider,
    bool? isMocked,
    bool? isSynced,
  }) => PositionTableData(
    id: id ?? this.id,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    accuracy: accuracy ?? this.accuracy,
    altitude: altitude ?? this.altitude,
    heading: heading ?? this.heading,
    speed: speed ?? this.speed,
    timestamp: timestamp ?? this.timestamp,
    provider: provider ?? this.provider,
    isMocked: isMocked ?? this.isMocked,
    isSynced: isSynced ?? this.isSynced,
  );
  PositionTableData copyWithCompanion(PositionTableCompanion data) {
    return PositionTableData(
      id: data.id.present ? data.id.value : this.id,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      altitude: data.altitude.present ? data.altitude.value : this.altitude,
      heading: data.heading.present ? data.heading.value : this.heading,
      speed: data.speed.present ? data.speed.value : this.speed,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      provider: data.provider.present ? data.provider.value : this.provider,
      isMocked: data.isMocked.present ? data.isMocked.value : this.isMocked,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PositionTableData(')
          ..write('id: $id, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('altitude: $altitude, ')
          ..write('heading: $heading, ')
          ..write('speed: $speed, ')
          ..write('timestamp: $timestamp, ')
          ..write('provider: $provider, ')
          ..write('isMocked: $isMocked, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    latitude,
    longitude,
    accuracy,
    altitude,
    heading,
    speed,
    timestamp,
    provider,
    isMocked,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PositionTableData &&
          other.id == this.id &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.accuracy == this.accuracy &&
          other.altitude == this.altitude &&
          other.heading == this.heading &&
          other.speed == this.speed &&
          other.timestamp == this.timestamp &&
          other.provider == this.provider &&
          other.isMocked == this.isMocked &&
          other.isSynced == this.isSynced);
}

class PositionTableCompanion extends UpdateCompanion<PositionTableData> {
  final Value<int> id;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double> accuracy;
  final Value<double> altitude;
  final Value<double> heading;
  final Value<double> speed;
  final Value<DateTime> timestamp;
  final Value<String> provider;
  final Value<bool> isMocked;
  final Value<bool> isSynced;
  const PositionTableCompanion({
    this.id = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.altitude = const Value.absent(),
    this.heading = const Value.absent(),
    this.speed = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.provider = const Value.absent(),
    this.isMocked = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  PositionTableCompanion.insert({
    this.id = const Value.absent(),
    required double latitude,
    required double longitude,
    required double accuracy,
    required double altitude,
    required double heading,
    required double speed,
    required DateTime timestamp,
    required String provider,
    required bool isMocked,
    this.isSynced = const Value.absent(),
  }) : latitude = Value(latitude),
       longitude = Value(longitude),
       accuracy = Value(accuracy),
       altitude = Value(altitude),
       heading = Value(heading),
       speed = Value(speed),
       timestamp = Value(timestamp),
       provider = Value(provider),
       isMocked = Value(isMocked);
  static Insertable<PositionTableData> custom({
    Expression<int>? id,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? accuracy,
    Expression<double>? altitude,
    Expression<double>? heading,
    Expression<double>? speed,
    Expression<DateTime>? timestamp,
    Expression<String>? provider,
    Expression<bool>? isMocked,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (accuracy != null) 'accuracy': accuracy,
      if (altitude != null) 'altitude': altitude,
      if (heading != null) 'heading': heading,
      if (speed != null) 'speed': speed,
      if (timestamp != null) 'timestamp': timestamp,
      if (provider != null) 'provider': provider,
      if (isMocked != null) 'is_mocked': isMocked,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  PositionTableCompanion copyWith({
    Value<int>? id,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<double>? accuracy,
    Value<double>? altitude,
    Value<double>? heading,
    Value<double>? speed,
    Value<DateTime>? timestamp,
    Value<String>? provider,
    Value<bool>? isMocked,
    Value<bool>? isSynced,
  }) {
    return PositionTableCompanion(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      altitude: altitude ?? this.altitude,
      heading: heading ?? this.heading,
      speed: speed ?? this.speed,
      timestamp: timestamp ?? this.timestamp,
      provider: provider ?? this.provider,
      isMocked: isMocked ?? this.isMocked,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<double>(accuracy.value);
    }
    if (altitude.present) {
      map['altitude'] = Variable<double>(altitude.value);
    }
    if (heading.present) {
      map['heading'] = Variable<double>(heading.value);
    }
    if (speed.present) {
      map['speed'] = Variable<double>(speed.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (isMocked.present) {
      map['is_mocked'] = Variable<bool>(isMocked.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PositionTableCompanion(')
          ..write('id: $id, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('altitude: $altitude, ')
          ..write('heading: $heading, ')
          ..write('speed: $speed, ')
          ..write('timestamp: $timestamp, ')
          ..write('provider: $provider, ')
          ..write('isMocked: $isMocked, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PositionTableTable positionTable = $PositionTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [positionTable];
}

typedef $$PositionTableTableCreateCompanionBuilder =
    PositionTableCompanion Function({
      Value<int> id,
      required double latitude,
      required double longitude,
      required double accuracy,
      required double altitude,
      required double heading,
      required double speed,
      required DateTime timestamp,
      required String provider,
      required bool isMocked,
      Value<bool> isSynced,
    });
typedef $$PositionTableTableUpdateCompanionBuilder =
    PositionTableCompanion Function({
      Value<int> id,
      Value<double> latitude,
      Value<double> longitude,
      Value<double> accuracy,
      Value<double> altitude,
      Value<double> heading,
      Value<double> speed,
      Value<DateTime> timestamp,
      Value<String> provider,
      Value<bool> isMocked,
      Value<bool> isSynced,
    });

class $$PositionTableTableFilterComposer
    extends Composer<_$AppDatabase, $PositionTableTable> {
  $$PositionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heading => $composableBuilder(
    column: $table.heading,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMocked => $composableBuilder(
    column: $table.isMocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PositionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PositionTableTable> {
  $$PositionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heading => $composableBuilder(
    column: $table.heading,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMocked => $composableBuilder(
    column: $table.isMocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PositionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PositionTableTable> {
  $$PositionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<double> get altitude =>
      $composableBuilder(column: $table.altitude, builder: (column) => column);

  GeneratedColumn<double> get heading =>
      $composableBuilder(column: $table.heading, builder: (column) => column);

  GeneratedColumn<double> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<bool> get isMocked =>
      $composableBuilder(column: $table.isMocked, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$PositionTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PositionTableTable,
          PositionTableData,
          $$PositionTableTableFilterComposer,
          $$PositionTableTableOrderingComposer,
          $$PositionTableTableAnnotationComposer,
          $$PositionTableTableCreateCompanionBuilder,
          $$PositionTableTableUpdateCompanionBuilder,
          (
            PositionTableData,
            BaseReferences<
              _$AppDatabase,
              $PositionTableTable,
              PositionTableData
            >,
          ),
          PositionTableData,
          PrefetchHooks Function()
        > {
  $$PositionTableTableTableManager(_$AppDatabase db, $PositionTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PositionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PositionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PositionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double> accuracy = const Value.absent(),
                Value<double> altitude = const Value.absent(),
                Value<double> heading = const Value.absent(),
                Value<double> speed = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<bool> isMocked = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => PositionTableCompanion(
                id: id,
                latitude: latitude,
                longitude: longitude,
                accuracy: accuracy,
                altitude: altitude,
                heading: heading,
                speed: speed,
                timestamp: timestamp,
                provider: provider,
                isMocked: isMocked,
                isSynced: isSynced,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double latitude,
                required double longitude,
                required double accuracy,
                required double altitude,
                required double heading,
                required double speed,
                required DateTime timestamp,
                required String provider,
                required bool isMocked,
                Value<bool> isSynced = const Value.absent(),
              }) => PositionTableCompanion.insert(
                id: id,
                latitude: latitude,
                longitude: longitude,
                accuracy: accuracy,
                altitude: altitude,
                heading: heading,
                speed: speed,
                timestamp: timestamp,
                provider: provider,
                isMocked: isMocked,
                isSynced: isSynced,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PositionTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PositionTableTable,
      PositionTableData,
      $$PositionTableTableFilterComposer,
      $$PositionTableTableOrderingComposer,
      $$PositionTableTableAnnotationComposer,
      $$PositionTableTableCreateCompanionBuilder,
      $$PositionTableTableUpdateCompanionBuilder,
      (
        PositionTableData,
        BaseReferences<_$AppDatabase, $PositionTableTable, PositionTableData>,
      ),
      PositionTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PositionTableTableTableManager get positionTable =>
      $$PositionTableTableTableManager(_db, _db.positionTable);
}
