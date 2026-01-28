import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/position.dart';

/// [LocationRepository] defines the contract for accessing location data.
/// It abstracts the underlying hardware implementation (Geolocator, FusedLocationProvider, etc.).
/// 
/// Embraces "Battery-Aware" principles by separating stream subscriptions from single-point checks.
abstract class LocationRepository {
  /// Returns a stream of [Position] updates.
  /// 
  /// Errors are emitted as [Failure] events wrapped in the stream or as stream errors,
  /// but here we use a Stream of Either to explicitly handle failures in the stream flow 
  /// without breaking the subscription if desired, or standard Stream<Position> with error handlers.
  /// 
  /// Choice: Stream<Either<Failure, Position>> favors explicit handling of interim failures 
  /// (e.g., temporary GPS loss) without terminating the stream.
  Stream<Either<Failure, Position>> getPositionStream({
    int intervalMs = 1000,
    int distanceFilterMeters = 0,
  });

  /// Get full history
  Future<Either<Failure, List<Position>>> getHistory();

  /// Gets a single high-accuracy position.
  /// Useful for "Audit Snapshots".
  Future<Either<Failure, Position>> getCurrentPosition();

  /// Gets the last known position from cache/hardware memory.
  /// Extremely battery efficient, instant return.
  Future<Either<Failure, Position?>> getLastKnownPosition();

  /// verify if location services are enabled on the device.
  Future<Either<Failure, bool>> isLocationServiceEnabled();

  /// Check location permissions.
  Future<Either<Failure, bool>> checkPermission();

  /// Request location permissions.
  Future<Either<Failure, bool>> requestPermission();
}
