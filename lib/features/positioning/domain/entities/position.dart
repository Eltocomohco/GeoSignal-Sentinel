import 'package:equatable/equatable.dart';

enum LocationProviderType {
  gps,
  network,
  fused,
  mock,
  unknown;
}

/// [Position] represents a geospatial location with auditing metadata.
/// Designed for high-precision auditing, capturing raw signal characteristics where possible.
class Position extends Equatable {
  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double heading;
  final double speed;
  /// Timestamp of when the signal was actually captured (not just received).
  final DateTime timestamp;
  /// The source of the location data.
  final LocationProviderType provider;
  /// Flag to indicate if the location might be spoofed or from a developer setting.
  final bool isMocked;
  
  // Future-proofing for raw signal strength auditing (e.g., GPS SNR, WiFi RSSI fusion result)
  final Map<String, dynamic>? auditingMetadata;

  const Position({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.timestamp,
    this.altitude = 0.0,
    this.heading = 0.0,
    this.speed = 0.0,
    this.provider = LocationProviderType.unknown,
    this.isMocked = false,
    this.auditingMetadata,
  });

  /// Factory for creating an empty/invalid position if needed, or initial state.
  factory Position.empty() {
    return Position(
      latitude: 0,
      longitude: 0,
      accuracy: 0,
      timestamp: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        accuracy,
        altitude,
        heading,
        speed,
        timestamp,
        provider,
        isMocked,
        auditingMetadata,
      ];

  @override
  String toString() {
    return 'Position(lat: $latitude, lng: $longitude, acc: $accuracy, provider: ${provider.name}, mocked: $isMocked)';
  }
}
