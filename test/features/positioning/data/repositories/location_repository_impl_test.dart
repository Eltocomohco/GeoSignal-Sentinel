import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:geosignal_sentinel/core/error/exceptions.dart';
import 'package:geosignal_sentinel/core/error/failures.dart';
import 'package:geosignal_sentinel/features/positioning/data/datasources/location_datasource.dart';
import 'package:geosignal_sentinel/features/positioning/data/models/position_dto.dart';
import 'package:geosignal_sentinel/features/positioning/data/datasources/local/local_location_datasource.dart';
import 'package:geosignal_sentinel/features/positioning/data/repositories/location_repository_impl.dart';
import 'package:geosignal_sentinel/features/positioning/domain/entities/position.dart';

import 'location_repository_impl_test.mocks.dart';

@GenerateMocks([LocationDataSource, LocalLocationDataSource])
void main() {
  late LocationRepositoryImpl repository;
  late MockLocationDataSource mockRemoteDataSource;
  late MockLocalLocationDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockLocationDataSource();
    mockLocalDataSource = MockLocalLocationDataSource();
    repository = LocationRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTimestamp = DateTime.now();
  final tPositionDto = PositionDto(
    latitude: 10.0,
    longitude: 20.0,
    accuracy: 5.0,
    timestamp: tTimestamp,
    provider: LocationProviderType.gps,
    altitude: 0,
    heading: 0,
    speed: 0,
    isMocked: false,
  );
  final Position tPosition = tPositionDto;

  group('getCurrentPosition', () {
    test('should return Position when call to data source is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getCurrentPosition()).thenAnswer((_) async => tPositionDto);
      // Act
      final result = await repository.getCurrentPosition();
      // Assert
      expect(result, Right(tPosition));
      verify(mockRemoteDataSource.getCurrentPosition());
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return LocationFailure when call to data source throws ServerException', () async {
      // Arrange
      when(mockRemoteDataSource.getCurrentPosition()).thenThrow(ServerException('Error'));
      // Act
      final result = await repository.getCurrentPosition();
      // Assert
      expect(result, const Left(LocationFailure('Error')));
    });
  });

  group('getPositionStream', () {
      test('should emit Position when stream emits successfully', () async {
        // Arrange
        when(mockRemoteDataSource.getPositionStream(intervalMs: anyNamed('intervalMs'), distanceFilterMeters: anyNamed('distanceFilterMeters')))
            .thenAnswer((_) => Stream.value(tPositionDto));
            
        // Stub local save to avoid null errors (Fire-and-forget)
        when(mockLocalDataSource.savePosition(any)).thenAnswer((_) async => {});
        
        // Act
        final stream = repository.getPositionStream();
        
        // Assert
        expect(stream, emits(Right(tPositionDto)));
      });

      test('should emit LocationFailure when stream emits error', () async {
         // Arrange
        final controller = StreamController<PositionDto>();
        when(mockRemoteDataSource.getPositionStream(intervalMs: anyNamed('intervalMs'), distanceFilterMeters: anyNamed('distanceFilterMeters')))
            .thenAnswer((_) => controller.stream);

        // Act
        final stream = repository.getPositionStream();
        
        // Assert
        expect(stream, emits(isA<Left>()));
        
        controller.addError(ServerException('Stream Error'));
        controller.close();
      });
  });
}
