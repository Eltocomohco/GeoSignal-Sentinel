import 'package:flutter_test/flutter_test.dart';
import 'package:geosignal_sentinel/features/positioning/domain/entities/position.dart';

void main() {
  group('Position', () {
    test('supports value equality', () {
      final tTimestamp = DateTime.now();
      final position1 = Position(
        latitude: 10.0,
        longitude: 20.0,
        accuracy: 5.0,
        timestamp: tTimestamp,
        provider: LocationProviderType.gps,
      );
      final position2 = Position(
        latitude: 10.0,
        longitude: 20.0,
        accuracy: 5.0,
        timestamp: tTimestamp,
        provider: LocationProviderType.gps,
      );

      expect(position1, equals(position2));
    });

    test('props are correct', () {
      final tTimestamp = DateTime(2023);
      final position = Position(
        latitude: 1.0,
        longitude: 2.0,
        accuracy: 3.0,
        timestamp: tTimestamp,
      );

      expect(
        position.props,
        [1.0, 2.0, 3.0, 0.0, 0.0, 0.0, tTimestamp, LocationProviderType.unknown, false, null],
      );
    });
  });
}
