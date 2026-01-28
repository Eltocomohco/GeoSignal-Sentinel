import 'package:flutter/material.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/wifi_network.dart';
import '../../domain/repositories/signal_repository.dart';

class SignalMonitor extends StatelessWidget {
  const SignalMonitor({super.key});

  @override
  Widget build(BuildContext context) {
    // Inyección Directa para visualizar flujo separado (Demo Arquitectónica)
    // En producción iría en su propio BLoC.
    final signalRepository = sl<SignalRepository>();

    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('ESCÁNER RF (NATIVO)', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 150,
            child: StreamBuilder(
              stream: signalRepository.getWifiScanStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error RF: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
                }
                
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                }

                return snapshot.data!.fold(
                  (failure) => Center(child: Text(failure.message)), 
                  (networks) {
                    if (networks.isEmpty) return const Center(child: Text('Escaneando... (Sin redes)'));
                    
                    // Top 5 sorted by Signal Strength
                    networks.sort((a, b) => b.rssi.compareTo(a.rssi));
                    final topNetworks = networks.take(5).toList();

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: topNetworks.length,
                      separatorBuilder: (_,__) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final net = topNetworks[index];
                        return ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.wifi, color: _getRssiColor(net.rssi)),
                          title: Text(net.ssid.isEmpty ? '[Oculta]' : net.ssid, style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text('${net.rssi} dBm', style: const TextStyle(fontFamily: 'Courier')),
                          subtitle: Text(net.bssid),
                        );
                      },
                    );
                  }
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getRssiColor(int rssi) {
    if (rssi > -60) return Colors.green;
    if (rssi > -80) return Colors.orange;
    return Colors.red;
  }
}
