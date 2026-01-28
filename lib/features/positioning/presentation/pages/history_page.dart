import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/history/history_bloc.dart';
import '../bloc/history/history_event.dart';
import '../bloc/history/history_state.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ya no creamos el Bloc aquí, usamos el global de main.dart
    return Scaffold(
        appBar: AppBar(
          title: const Text('Auditoría Forense'),
          actions: [
            BlocBuilder<HistoryBloc, HistoryState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: state.positions.isEmpty 
                    ? null 
                    : () => context.read<HistoryBloc>().add(const HistoryExported()),
                  tooltip: 'Exportar CSV',
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<HistoryBloc, HistoryState>(
          listener: (context, state) {
            if (state.message != null && state.message!.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message!)),
              );
            }
          },
          builder: (context, state) {
            if (state.status == HistoryStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (state.status == HistoryStatus.failure) {
              return Center(child: Text('Error: ${state.message}'));
            }

            if (state.positions.isEmpty) {
               return const Center(child: Text('Sin registros de auditoría.'));
            }

            return ListView.separated(
              itemCount: state.positions.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                // Show newest first usually, but List is chronological. Reverse access?
                // Or sort in Bloc. Let's show as is (Chronological) or reversed.
                final position = state.positions[state.positions.length - 1 - index];
                
                return ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(
                    '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${position.timestamp.toIso8601String().split('T')[1].split('.')[0]} • Acc: ${position.accuracy.toStringAsFixed(1)}m • ${position.provider.name.toUpperCase()}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: position.isMocked 
                    ? const Icon(Icons.warning, color: Colors.orange, size: 16) 
                    : null,
                );
              },
            );
          },
        ),
    );
  }
}

