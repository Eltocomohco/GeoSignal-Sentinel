import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../../../features/positioning/data/models/position_dto.dart';
import '../../../../../features/positioning/domain/entities/position.dart';

part 'app_database.g.dart';

class PositionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get accuracy => real()();
  RealColumn get altitude => real()();
  RealColumn get heading => real()();
  RealColumn get speed => real()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get provider => text()();
  BoolColumn get isMocked => boolean()();
  // Sync flag
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [PositionTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
  
  // Create Position
  Future<int> insertPosition(PositionDto dto) {
    return into(positionTable).insert(PositionTableCompanion.insert(
      latitude: dto.latitude,
      longitude: dto.longitude,
      accuracy: dto.accuracy,
      altitude: dto.altitude,
      heading: dto.heading,
      speed: dto.speed,
      timestamp: dto.timestamp,
      provider: dto.provider.name,
      isMocked: dto.isMocked,
      isSynced: const Value(false),
    ));
  }

  // Get History
  Future<List<PositionDto>> getHistory() async {
    final rows = await select(positionTable).get();
    return rows.map((row) => PositionDto(
      latitude: row.latitude,
      longitude: row.longitude,
      accuracy: row.accuracy,
      timestamp: row.timestamp,
      altitude: row.altitude,
      heading: row.heading,
      speed: row.speed,
      isMocked: row.isMocked,
      provider: _parseProvider(row.provider),
    )).toList();
  }
  
  LocationProviderType _parseProvider(String value) {
    try {
      return LocationProviderType.values.firstWhere((e) => e.name == value);
    } catch (_) {
      return LocationProviderType.unknown;
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
