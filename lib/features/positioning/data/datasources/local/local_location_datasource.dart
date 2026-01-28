import '../../models/position_dto.dart';

abstract class LocalLocationDataSource {
  Future<void> savePosition(PositionDto position);
  Future<List<PositionDto>> getHistory();
}
