import 'package:equatable/equatable.dart';

class WifiNetwork extends Equatable {
  final String ssid;
  final String bssid;
  final int rssi;
  final int frequency;
  final DateTime timestamp;

  const WifiNetwork({
    required this.ssid,
    required this.bssid,
    required this.rssi,
    required this.frequency,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [ssid, bssid, rssi, frequency, timestamp];
  
  @override
  String toString() => 'Wifi($ssid, $rssi dBm)';
}
