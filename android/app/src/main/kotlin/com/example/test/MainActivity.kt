package com.example.test

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.wifi.WifiManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.geosignal.sentinel/wifi_scan"
    private var wifiManager: WifiManager? = null
    private var wifiScanReceiver: BroadcastReceiver? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    startWifiScan(events)
                }

                override fun onCancel(arguments: Any?) {
                    stopWifiScan()
                }
            }
        )
    }

    private fun startWifiScan(events: EventChannel.EventSink?) {
        wifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager

        wifiScanReceiver = object : BroadcastReceiver() {
            override fun onReceive(c: Context, intent: Intent) {
                val success = intent.getBooleanExtra(WifiManager.EXTRA_RESULTS_UPDATED, false)
                if (success) {
                    val scanResults = wifiManager?.scanResults
                    val resultsList = ArrayList<Map<String, Any>>()

                    scanResults?.forEach {
                        val map = HashMap<String, Any>()
                        map["ssid"] = it.SSID ?: ""
                        map["bssid"] = it.BSSID ?: ""
                        map["rssi"] = it.level
                        map["frequency"] = it.frequency
                        resultsList.add(map)
                    }
                    events?.success(resultsList)
                } else {
                    // Scan failure, send empty or error? For now empty list to keep stream alive
                     events?.success(emptyList<Map<String, Any>>())
                }
                // Trigger next scan? For strict auditing we might want continuous scanning
                // But Android throttles this heavily (4 scans per 2 min in foreground).
                // We rely on external trigger or simple throttle. 
                // For this demo, we scan once per receiver but the EventChannel is active.
                // To keep scanning, we'd need a Handler/Timer.
                // Let's implement a loop
                android.os.Handler(android.os.Looper.getMainLooper()).postDelayed({
                    wifiManager?.startScan()
                }, 10000) // 10 seconds delay to avoid throttle
            }
        }

        val intentFilter = IntentFilter()
        intentFilter.addAction(WifiManager.SCAN_RESULTS_AVAILABLE_ACTION)
        registerReceiver(wifiScanReceiver, intentFilter)

        // Initial Scan
        val success = wifiManager?.startScan()
        if (success != true) {
            // events?.error("SCAN_FAILED", "Could not start scan", null)
        }
    }

    private fun stopWifiScan() {
        try {
            if (wifiScanReceiver != null) {
                unregisterReceiver(wifiScanReceiver)
                wifiScanReceiver = null
            }
        } catch (e: Exception) {
            // Ignore if not registered
        }
    }
}
