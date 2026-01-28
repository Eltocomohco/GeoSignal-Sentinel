import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/wifi_network.dart';

abstract class SignalRepository {
  /// Un stream continuo de "Resultados de Escaneo".
  /// Cada evento es una lista de redes encontradas en un barrido.
  Stream<Either<Failure, List<WifiNetwork>>> getWifiScanStream();
}
