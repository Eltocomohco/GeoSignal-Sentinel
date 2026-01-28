import 'package:geolocator/geolocator.dart';
import '../../../../core/error/exceptions.dart';
import '../models/position_dto.dart';
import 'location_datasource.dart';

class GeolocatorDataSource implements LocationDataSource {
  @override
  Stream<PositionDto> getPositionStream({int intervalMs = 1000, int distanceFilterMeters = 0}) {
    // Battery Aware: Use specific settings to avoid overkill updates.
    final settings = LocationSettings(
      accuracy: LocationAccuracy.high, // Necessary for auditing, but expensive.
      distanceFilter: distanceFilterMeters,
      // timeLimit: Duration(milliseconds: intervalMs) // Note: not all platforms support time filtering
    );

    return Geolocator.getPositionStream(locationSettings: settings).map((p) => PositionDto.fromGeolocator(p));
  }

  @override
  Future<PositionDto> getCurrentPosition() async {
    try {
      final p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return PositionDto.fromGeolocator(p);
    } catch (e) {
      throw ServerException(e.toString()); // Generic map, refine later
    }
  }

  @override
  Future<PositionDto?> getLastKnownPosition() async {
    final p = await Geolocator.getLastKnownPosition();
    if (p == null) return null;
    return PositionDto.fromGeolocator(p);
  }

  @override
  Future<bool> checkPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
  }
  
  @override
  Future<bool> requestPermission() async {
    final permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
}
