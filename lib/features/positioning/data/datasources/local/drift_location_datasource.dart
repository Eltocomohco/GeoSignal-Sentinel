import 'database/app_database.dart';
import '../../models/position_dto.dart';
import 'local_location_datasource.dart';

class DriftLocationDataSource implements LocalLocationDataSource {
  final AppDatabase database;

  DriftLocationDataSource({required this.database});

  @override
  Future<void> savePosition(PositionDto position) {
    return database.insertPosition(position);
  }

  @override
  Future<List<PositionDto>> getHistory() {
    return database.getHistory();
  }
}
