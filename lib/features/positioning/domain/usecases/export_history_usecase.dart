import 'dart:io';
import 'package:csv/csv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:geosignal_sentinel/core/error/failures.dart';
import 'package:geosignal_sentinel/features/positioning/domain/entities/position.dart';

class ExportHistoryUseCase {
  
  Future<Either<Failure, void>> call(List<Position> history) async {
    try {
      // 1. Convert to List<List<dynamic>> for CSV
      List<List<dynamic>> rows = [];
      
      // Header
      rows.add([
        "Timestamp",
        "Latitude",
        "Longitude",
        "Accuracy (m)",
        "Altitude (m)",
        "Speed (m/s)",
        "Provider"
      ]);

      // Data
      for (var pos in history) {
        rows.add([
          pos.timestamp.toIso8601String(),
          pos.latitude,
          pos.longitude,
          pos.accuracy,
          pos.altitude,
          pos.speed,
          pos.provider.name,
        ]);
      }

      // 2. Encoded to CSV String
      String csvData = const ListToCsvConverter().convert(rows);

      // 3. Save to Temp File
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/audit_export_${DateTime.now().millisecondsSinceEpoch}.csv';
      final file = File(path);
      await file.writeAsString(csvData);

      // 4. Share using SharePlus
      final result = await Share.shareXFiles([XFile(path)], text: 'GeoSignal Audit Log');
      
      if (result.status == ShareResultStatus.dismissed) {
         // User cancelled, but operation was technically successful in generating
         return const Right(null);
      }
      
      return const Right(null);
    } catch (e) {
      return Left(LocationFailure("Error exporting CSV: $e"));
    }
  }
}
