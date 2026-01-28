import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/widgets/permission_guard.dart';
import 'features/positioning/presentation/pages/dashboard_page.dart';
import 'features/positioning/presentation/bloc/location_bloc.dart';
import 'features/positioning/presentation/bloc/signal/signal_bloc.dart';
import 'features/positioning/presentation/bloc/history/history_bloc.dart';
import 'features/positioning/presentation/bloc/history/history_event.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const GeoSignalApp());
}

class GeoSignalApp extends StatelessWidget {
  const GeoSignalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<LocationBloc>()),
        BlocProvider(create: (_) => di.sl<SignalBloc>()),
        BlocProvider(create: (_) => di.sl<HistoryBloc>()..add(const HistoryLoaded())),
      ],
      child: MaterialApp(
        title: 'GeoSignal Sentinel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, 
            brightness: Brightness.light
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, 
            brightness: Brightness.dark
          ),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const PermissionGuard(child: DashboardPage()),
      ),
    );
  }
}
