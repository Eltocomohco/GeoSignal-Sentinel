import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/signal/signal_bloc.dart';
import '../bloc/signal/signal_state.dart';

class SignalMonitor extends StatelessWidget {
  const SignalMonitor({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: BlocBuilder<SignalBloc, SignalState>(
              builder: (context, state) {
                if (state.status == SignalStatus.failure) {
                   return Center(child: Text('Error RF: ${state.errorMessage}', style: const TextStyle(color: Colors.red)));
                }

                if (state.status == SignalStatus.initial) {
                   return const Center(child: Text('Monitor Inactivo'));
                }
                
                if (state.networks.isEmpty) {
                   return const Center(child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       CircularProgressIndicator(strokeWidth: 2),
                       SizedBox(height: 8),
                       Text("Escaneando..."),
                     ],
                   ));
                }

                // Top 5 sorted by strength
                final topNetworks = List.of(state.networks)..sort((a, b) => b.rssi.compareTo(a.rssi));
                final displayList = topNetworks.take(5).toList();

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: displayList.length,
                  separatorBuilder: (_,__) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final net = displayList[index];
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
