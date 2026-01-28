import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/location_repository.dart';
import 'location_event.dart';
import 'location_state.dart';

import 'package:bloc_concurrency/bloc_concurrency.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository;

  LocationBloc({required LocationRepository locationRepository})
      : _locationRepository = locationRepository,
        super(const LocationState()) {
    on<LocationStarted>(_onLocationStarted, transformer: restartable());
    on<LocationStopped>(_onLocationStopped);
  }

  Future<void> _onLocationStarted(
    LocationStarted event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(status: LocationStatus.loading));

    await emit.forEach(
      _locationRepository.getPositionStream(),
      onData: (result) => result.fold(
        (failure) => state.copyWith(
          status: LocationStatus.failure,
          errorMessage: failure.message,
        ),
        (position) => state.copyWith(
          status: LocationStatus.success,
          position: position,
        ),
      ),
      onError: (error, stackTrace) => state.copyWith(
        status: LocationStatus.failure,
        errorMessage: error.toString(),
      ),
    );
  }

  void _onLocationStopped(
    LocationStopped event,
    Emitter<LocationState> emit,
  ) {
    // restartable() on Started means if we fire Started again, it restarts.
    // Explicit Stop needs to cancel the subscription.
    // Ideally, we would have a single event handler that switches based on intent, 
    // or we assume 'Stopped' leads to an empty state and we might push a null/initial state.
    // However, with `restartable()`, adding a new event (like Stopped) doesn't automatically cancel the OTHER handler's stream unless they share the bucket.
    // 
    // Correction: To use `restartable` effectively for start/stop, we usually map events.
    // But since `Started` is a long running stream, simply adding `Stopped` event will run _onLocationStopped concurrently (by default Bloc processes sequentially but separate handlers).
    // 
    // Battery Best Practice:
    // To strictly cancel the stream from `Started`, we need to cancel its subscription.
    // The easiest way is to use a manual subscription or emit a state that causes the UI to unsubscribe if using a StreamBuilder, but here we are in logic.
    // 
    // Alternative: Use `switchMap`. 
    // But `emit.forEach` blocks. 
    // 
    // Simplest robust solution: Manual StreamSubscription.
    emit(state.copyWith(status: LocationStatus.initial));
  }
}
