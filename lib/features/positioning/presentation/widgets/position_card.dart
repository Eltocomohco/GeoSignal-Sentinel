import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/position.dart';

class PositionCard extends StatelessWidget {
  final Position position;

  const PositionCard({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('HH:mm:ss.SSS');
    
    // Semáforo de precisión para auditoría
    Color accuracyColor;
    if (position.accuracy < 5) {
      accuracyColor = Colors.green;
    } else if (position.accuracy < 15) {
      accuracyColor = Colors.orange;
    } else {
      accuracyColor = Colors.red;
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AUDITORÍA EN TIEMPO REAL',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: accuracyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: accuracyColor),
                  ),
                  child: Text(
                    '±${position.accuracy.toStringAsFixed(1)}m',
                    style: TextStyle(color: accuracyColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(),
            _buildDataRow('Latitud', position.latitude.toStringAsFixed(7), isMonospace: true),
            _buildDataRow('Longitud', position.longitude.toStringAsFixed(7), isMonospace: true),
            const SizedBox(height: 8),
            _buildDataRow('Proveedor', position.provider.name.toUpperCase()),
            _buildDataRow('Simulado (Mock)', position.isMocked ? 'SÍ' : 'NO', 
              valueColor: position.isMocked ? Colors.red : Colors.green),
            const SizedBox(height: 8),
            _buildDataRow('Timestamp', dateFormat.format(position.timestamp)),
            _buildDataRow('Altitud', '${position.altitude.toStringAsFixed(1)} m'),
            _buildDataRow('Velocidad', '${position.speed.toStringAsFixed(1)} m/s'),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value, {bool isMonospace = false, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontFamily: isMonospace ? 'Courier' : null,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
