import 'package:geolocator/geolocator.dart' as geo;
import '../../domain/entities/position.dart';

/// [PositionDto] is a Data Transfer Object to handle raw data from sources.
/// It wraps or converts external models (like Geolocator's Position) to our Domain Entity.
class PositionDto extends Position {
  const PositionDto({
    required super.latitude,
    required super.longitude,
    required super.accuracy,
    required super.timestamp,
    super.altitude,
    super.heading,
    super.speed,
    super.provider,
    super.isMocked,
    super.auditingMetadata,
  });

  /// Mapper from Geolocator platform object to our DTO/Entity.
  factory PositionDto.fromGeolocator(geo.Position p) {
    return PositionDto(
      latitude: p.latitude,
      longitude: p.longitude,
      accuracy: p.accuracy,
      altitude: p.altitude,
      heading: p.heading,
      speed: p.speed,
      timestamp: p.timestamp,
      isMocked: p.isMocked,
      provider: LocationProviderType.gps, // Geolocator doesn't easily expose provider type, default to generic or inferred.
      // In a real advanced app, we'd use NMEA parsing to determine provider/satellites
    );
  }
}
