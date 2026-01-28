import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../bloc/location_bloc.dart';
import '../bloc/location_state.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  bool _shouldFollowUser = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ruta en Tiempo Real'),
        actions: [
          IconButton(
            icon: Icon(_shouldFollowUser ? Icons.gps_fixed : Icons.gps_not_fixed),
            tooltip: _shouldFollowUser ? 'Siguiendo' : 'Seguir Usuario',
            onPressed: () {
              setState(() {
                _shouldFollowUser = !_shouldFollowUser;
              });
            },
          )
        ],
      ),
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state.position != null && _shouldFollowUser) {
            _mapController.move(
              LatLng(state.position!.latitude, state.position!.longitude),
              _mapController.camera.zoom,
            );
          }
        },
        builder: (context, state) {
          // Si no hay posición inicial, mostrar loading o un punto por defecto
          final currentPos = state.position != null
              ? LatLng(state.position!.latitude, state.position!.longitude)
              : const LatLng(40.416775, -3.703790); // Madrid Default

          // Convertir historial (o puntos acumulados) a Polyline
          // NOTA: El LocationState actual solo tiene 'position' (última).
          // Para dibujar la línea completa necesitaríamos acceder al historial acumulado en memoria
          // o que el Bloc mantenga una lista `path`. 
          // Por simplicidad en este paso, dibujaremos Puntos si extendemos el estado, 
          // o simplemente mostramos la posición actual.
          // MEJORA: Vamos a pedir al Bloc que nos de la lista si la tuviera, 
          // pero como 'HistoryBloc' tiene el historial persistido, podríamos conectar ambos.
          // Por ahora: Solo Marker en posición actual.
          
          return FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: currentPos,
              initialZoom: 18.0,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
              onPositionChanged: (pos, hasGesture) {
                if (hasGesture && _shouldFollowUser) {
                  setState(() => _shouldFollowUser = false);
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.geosignal.sentinel',
              ),
              MarkerLayer(
                markers: [
                  if (state.position != null)
                    Marker(
                      point: currentPos,
                      width: 80,
                      height: 80,
                      child: const Icon(
                        Icons.navigation, 
                        color: Colors.blue, 
                        size: 40,
                        shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                      ),
                    ),
                ],
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
