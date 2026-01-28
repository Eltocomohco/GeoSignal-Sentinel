import 'package:flutter/material.dart';

import 'core/widgets/permission_guard.dart';
import 'features/positioning/presentation/pages/dashboard_page.dart';
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
    return MaterialApp(
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
      themeMode: ThemeMode.system, // Soporte automático para Dark Mode
      home: const PermissionGuard(child: DashboardPage()),
    );
  }
}
