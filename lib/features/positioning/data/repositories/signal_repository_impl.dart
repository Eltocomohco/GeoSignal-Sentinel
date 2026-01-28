import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/wifi_network.dart';
import '../../domain/repositories/signal_repository.dart';
import '../datasources/signal_method_channel_datasource.dart';

class SignalRepositoryImpl implements SignalRepository {
  final SignalDataSource dataSource;

  SignalRepositoryImpl({required this.dataSource});

  @override
  Stream<Either<Failure, List<WifiNetwork>>> getWifiScanStream() {
    return dataSource.getWifiScanStream().map<Either<Failure, List<WifiNetwork>>>((networks) {
      return Right(networks);
    }).handleError((error) {
       return Left(LocationFailure(error.toString()));
    });
  }
}
