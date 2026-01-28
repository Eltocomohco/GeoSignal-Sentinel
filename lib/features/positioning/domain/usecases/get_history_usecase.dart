import 'package:fpdart/fpdart.dart';
import 'package:geosignal_sentinel/core/error/failures.dart';
import 'package:geosignal_sentinel/features/positioning/domain/entities/position.dart';
import 'package:geosignal_sentinel/features/positioning/domain/repositories/location_repository.dart';

class GetHistoryUseCase {
  final LocationRepository repository;

  GetHistoryUseCase(this.repository);

  Future<Either<Failure, List<Position>>> call() {
    // We haven't implemented getHistory in the interface properly yet, we'll need to add it.
    // For now, let's assume we will add it to the repository.
    return repository.getHistory();
  }
}
