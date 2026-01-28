import 'package:get_it/get_it.dart';

import 'features/positioning/data/datasources/geolocator_datasource.dart';
import 'features/positioning/data/datasources/location_datasource.dart';
import 'features/positioning/data/datasources/local/database/app_database.dart';
import 'features/positioning/data/datasources/local/drift_location_datasource.dart';
import 'features/positioning/data/datasources/local/local_location_datasource.dart';
import 'features/positioning/data/datasources/signal_method_channel_datasource.dart';
import 'features/positioning/data/repositories/location_repository_impl.dart';
import 'features/positioning/data/repositories/signal_repository_impl.dart';
import 'features/positioning/domain/repositories/location_repository.dart';
import 'features/positioning/domain/repositories/signal_repository.dart';
import 'features/positioning/domain/repositories/signal_repository.dart';
import 'features/positioning/domain/repositories/signal_repository.dart';
import 'features/positioning/domain/usecases/get_live_position_usecase.dart';
import 'features/positioning/presentation/bloc/location_bloc.dart';
import 'features/positioning/presentation/bloc/signal/signal_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Positioning
  // UseCases
  sl.registerLazySingleton(() => GetLivePositionUseCase(sl()));

  // Bloc
  sl.registerFactory(() => LocationBloc(getLivePosition: sl()));
  sl.registerFactory(() => SignalBloc(repository: sl()));

  // Repository
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LocationDataSource>(
    () => GeolocatorDataSource(),
  );
  
  sl.registerLazySingleton<LocalLocationDataSource>(
    () => DriftLocationDataSource(database: sl()),
  );

  sl.registerLazySingleton<SignalDataSource>(
    () => MethodChannelSignalDataSource(),
  );

  sl.registerLazySingleton<SignalRepository>(
    () => SignalRepositoryImpl(dataSource: sl()),
  );
  
  // Database
  sl.registerLazySingleton(() => AppDatabase());
}
