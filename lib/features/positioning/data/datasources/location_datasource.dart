import '../models/position_dto.dart';

/// [LocationDataSource] defines the interface for data access.
/// This abstraction allows us to potentially swap the underlying provider 
/// (e.g., from Geolocator to a custom Native Implementation) without affecting the Repository.
abstract class LocationDataSource {
  Stream<PositionDto> getPositionStream({
    int intervalMs = 1000, 
    int distanceFilterMeters = 0
  });

  Future<PositionDto> getCurrentPosition();
  
  Future<PositionDto?> getLastKnownPosition();

  Future<bool> isLocationServiceEnabled();
  
  Future<bool> checkPermission();
  
  Future<bool> requestPermission();
}
