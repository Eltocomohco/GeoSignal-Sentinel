import 'package:flutter/services.dart';
import '../../domain/entities/wifi_network.dart';

abstract class SignalDataSource {
  Stream<List<WifiNetwork>> getWifiScanStream();
}

class MethodChannelSignalDataSource implements SignalDataSource {
  // Canal de Eventos para recibir streams desde nativo
  static const eventChannel = EventChannel('com.geosignal.sentinel/wifi_scan');

  @override
  Stream<List<WifiNetwork>> getWifiScanStream() {
    return eventChannel.receiveBroadcastStream().map((dynamic event) {
      final List<dynamic> list = event;
      return list.map((e) {
        final map = Map<String, dynamic>.from(e);
        return WifiNetwork(
          ssid: map['ssid'] ?? 'UNKNOWN',
          bssid: map['bssid'] ?? '',
          rssi: map['rssi'] ?? 0,
          frequency: map['frequency'] ?? 0,
          timestamp: DateTime.now(),
        );
      }).toList();
    });
  }
}
