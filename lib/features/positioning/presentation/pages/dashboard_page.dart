import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/location_bloc.dart';
import '../bloc/location_event.dart';
import '../bloc/location_state.dart';
import '../bloc/signal/signal_bloc.dart';
import '../bloc/signal/signal_event.dart';
import '../bloc/signal/signal_event.dart';
import '../bloc/location_state.dart';
import '../widgets/position_card.dart';
import '../widgets/signal_monitor.dart';
import 'history_page.dart';
import 'map_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DashboardView();
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoSignal Sentinel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
               Navigator.of(context).push(
                 MaterialPageRoute(builder: (_) => const HistoryPage()),
               );
            },
          ),
          IconButton(
            icon: const Icon(Icons.map),
            tooltip: 'Ver Mapa',
            onPressed: () {
               Navigator.of(context).push(
                 MaterialPageRoute(builder: (_) => const MapPage()),
               );
            },
          ),
        ],
      ),
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state.status == LocationStatus.failure && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == LocationStatus.loading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Iniciando sensores...'),
                ],
              ),
            );
          }
          
          if (state.position != null) {
            return Column(
              children: [
                PositionCard(position: state.position!),
                const SignalMonitor(),
                const Spacer(),
                if (state.status == LocationStatus.initial)
                   const Padding(
                     padding: EdgeInsets.all(16.0),
                     child: Text("Auditoría Pausada", style: TextStyle(color: Colors.orange)),
                   ),
              ],
            );
          }

          if (state.status == LocationStatus.initial) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.gps_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Sistema en Espera'),
                  Text('Presiona el botón para iniciar auditoría'),
                ],
              ),
            );
          }
          
          return const Center(child: Text("Estado desconocido"));
        },
      ),
      floatingActionButton: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          final isTracking = state.status == LocationStatus.success || state.status == LocationStatus.loading;
          
          return FloatingActionButton.extended(
            onPressed: () {
              if (isTracking) {
                // Detener ambos sensores
                context.read<LocationBloc>().add(const LocationStopped());
                context.read<SignalBloc>().add(const SignalScanStopped());
              } else {
                // Iniciar ambos sensores
                context.read<LocationBloc>().add(const LocationStarted());
                context.read<SignalBloc>().add(const SignalScanStarted());
              }
            },
            backgroundColor: isTracking ? Colors.red : Colors.green,
            icon: Icon(isTracking ? Icons.stop : Icons.play_arrow),
            label: Text(isTracking ? 'DETENER' : 'INICIAR'),
          );
        },
      ),
    );
  }
}
