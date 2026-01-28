import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionGuard extends StatefulWidget {
  final Widget child;

  const PermissionGuard({super.key, required this.child});

  @override
  State<PermissionGuard> createState() => _PermissionGuardState();
}

class _PermissionGuardState extends State<PermissionGuard> {
  bool _hasPermissions = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    // Audit requires High Precision stuff
    final locationStatus = await Permission.location.status;
    // For WiFi Scan on Android 13+ we need NEARBY_WIFI_DEVICES, on older is just location.
    // We request basic critical ones.
    
    // Check if granted
    if (locationStatus.isGranted) {
      if (mounted) {
        setState(() {
          _hasPermissions = true;
          _isLoading = false;
        });
      }
    } else {
       if (mounted) {
        setState(() {
          _hasPermissions = false;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _requestPermissions() async {
    setState(() => _isLoading = true);
    
    // Request critical permissions map
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.locationAlways, // For background audit
      // Permission.nearbyWifiDevices, // Critical for Android 13+ WiFi Scan
    ].request();

    // Check aggregate
    bool allGranted = statuses[Permission.location]?.isGranted == true;

    if (mounted) {
      setState(() {
        _hasPermissions = allGranted;
        _isLoading = false;
      });
      
      if (!allGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Se requieren permisos para auditar.'),
            backgroundColor: Colors.red,
          )
        );
        // Open settings if permanently denied
        if (statuses[Permission.location]?.isPermanentlyDenied == true) {
           openAppSettings();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_hasPermissions) {
      return widget.child;
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.security, size: 80, color: Colors.indigo),
              const SizedBox(height: 24),
              const Text(
                'Permisos Requeridos',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'GeoSignal Sentinel es una herramienta de auditoría profesional. Necesitamos acceso al GPS y Sensores para funcionar.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _requestPermissions,
                icon: const Icon(Icons.check),
                label: const Text('AUTORIZAR ACCESO'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
