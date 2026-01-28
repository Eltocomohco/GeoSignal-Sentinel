import 'dart:async';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/position.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_datasource.dart';
import '../datasources/local/local_location_datasource.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource remoteDataSource;
  final LocalLocationDataSource localDataSource;

  LocationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Stream<Either<Failure, Position>> getPositionStream({int intervalMs = 1000, int distanceFilterMeters = 0}) {
    return remoteDataSource.getPositionStream(intervalMs: intervalMs, distanceFilterMeters: distanceFilterMeters)
        .map<Either<Failure, Position>>((dto) {
          // Fire-and-forget save to local DB
          localDataSource.savePosition(dto).catchError((e) {
            // Log error silently, don't break the stream
            print('Error saving position locally: $e');
          });
          return Right(dto);
        })
        .transform(StreamTransformer<Either<Failure, Position>, Either<Failure, Position>>.fromHandlers(
          handleError: (error, stackTrace, sink) {
            if (error is ServerException) {
              sink.add(Left(LocationFailure(error.message)));
            } else {
              sink.add(Left(LocationFailure(error.toString())));
            }
          },
        ));
  }

  @override
  Future<Either<Failure, Position>> getCurrentPosition() async {
    try {
      final result = await remoteDataSource.getCurrentPosition();
      return Right(result);
    } on ServerException catch (e) {
      return Left(LocationFailure(e.message));
    } catch (e) {
      return Left(LocationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Position?>> getLastKnownPosition() async {
    try {
      final result = await remoteDataSource.getLastKnownPosition();
      return Right(result);
    } on ServerException catch (e) {
      return Left(LocationFailure(e.message)); // Or return Right(null) depending on business rule, but Failure is safer for "Error fetching" vs "No location".
    } catch (e) {
       return Left(LocationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkPermission() async {
    try {
      final result = await remoteDataSource.checkPermission();
      return Right(result);
    } catch (e) {
      return Left(PermissionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLocationServiceEnabled() async {
    try {
      final result = await remoteDataSource.isLocationServiceEnabled();
      return Right(result);
    } catch (e) {
      return Left(ServiceDisabledFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> requestPermission() async {
    try {
      final result = await remoteDataSource.requestPermission();
      return Right(result);
    } catch (e) {
      return Left(PermissionFailure(e.toString()));
    }
  }
}
