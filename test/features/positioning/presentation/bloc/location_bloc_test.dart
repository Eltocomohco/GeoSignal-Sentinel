
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:geosignal_sentinel/features/positioning/domain/entities/position.dart';
import 'package:geosignal_sentinel/features/positioning/domain/repositories/location_repository.dart';
import 'package:geosignal_sentinel/features/positioning/presentation/bloc/location_bloc.dart';
import 'package:geosignal_sentinel/features/positioning/presentation/bloc/location_event.dart';
import 'package:geosignal_sentinel/features/positioning/presentation/bloc/location_state.dart';

import 'location_bloc_test.mocks.dart';

@GenerateMocks([LocationRepository])
void main() {
  late LocationBloc bloc;
  late MockLocationRepository mockRepository;

  setUp(() {
    mockRepository = MockLocationRepository();
    bloc = LocationBloc(locationRepository: mockRepository);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is LocationState()', () {
    expect(bloc.state, const LocationState());
  });

  group('LocationStarted', () {
    final tPosition = Position(
      latitude: 1.0,
      longitude: 1.0,
      accuracy: 1.0,
      timestamp: DateTime.now(),
    );

    blocTest<LocationBloc, LocationState>(
      'emits [loading, success] when repository returns position stream successfully',
      build: () {
        when(mockRepository.getPositionStream())
            .thenAnswer((_) => Stream.value(Right(tPosition)));
        return bloc;
      },
      act: (bloc) => bloc.add(const LocationStarted()),
      expect: () => [
        const LocationState(status: LocationStatus.loading),
        LocationState(status: LocationStatus.success, position: tPosition),
      ],
    );
  });
}
