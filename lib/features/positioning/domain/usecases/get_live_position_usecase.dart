import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/position.dart';
import '../../domain/repositories/location_repository.dart';

class GetLivePositionUseCase {
  final LocationRepository repository;

  GetLivePositionUseCase(this.repository);

  // En Clean Arch estricta, los UseCases suelen tener un método call()
  Stream<Either<Failure, Position>> call() {
    return repository.getPositionStream(
      intervalMs: 1000, 
      distanceFilterMeters: 0
    );
  }
}
