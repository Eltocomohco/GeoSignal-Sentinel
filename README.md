# GeoSignal Sentinel 📡🛡️

> **Enterprise Infrastructure Auditor for Indoor Positioning Systems**

GeoSignal Sentinel es una herramienta de ingeniería diseñada para la auditoría, validación y depuración de infraestructuras de posicionamiento en interiores (IPS).

## 🚀 Propósito del Proyecto
Las señales GPS satelitales no penetran en interiores (Centros Comerciales, Aeropuertos, Fábricas). Para localizar activos o personas en estos entornos, se utilizan tecnologías híbridas (Wi-Fi, Bluetooth BLE, Geomagnético).

**Sentinel cubre la necesidad crítica de "Ground Truth" (Verdad Terrestre):**
Permite a los ingenieros de campo recolectar datos crudos de señales ($dBm$) georreferenciados para calibrar y entrenar algoritmos de localización.

## 💼 Casos de Uso (Business Capability)

1.  **Site Survey & Heatmaps**:
    *   Caminar por un edificio y generar un mapa de calor de cobertura Wi-Fi/BLE.
    *   Detectar "Zonas Muertas" donde la infraestructura falla.

2.  **Fingerprinting Dataset Generation**:
    *   Recolectar huellas digitales espectrales (Spectral Patterns) necesarias para sistemas como **Situm**, **Google Indoor Maps** o **Mapbox**.

3.  **Auditoría Forense (Black Box)**:
    *   Registro inmutable (SQLite) de todas las variaciones de señal segundo a segundo.
    *   Exportación CSV para análisis post-mortem en herramientas como Excel, Tableau o Python/Pandas.

## 🛠️ Arquitectura Técnica
Construido con Flutter y principios de Ingeniería de Software de alto nivel:

*   **Clean Architecture**: Separación estricta (Domain, Data, Presentation).
*   **Offline-First**: Base de datos `Drift` (SQLite) integrada para operar sin conexión.
*   **Battery-Aware**: Gestión inteligente de sensores nativos (Kotlin/Swift Interop).
*   **Reactive State**: Gestión de estado predecible con BLoC Pattern.

## 📦 Features
- [x] **Live Monitor**: Latitud, Longitud, Proveedor, Precisión.
- [x] **Signal Scanner**: Escáner nativo de redes Wi-Fi (SSID, BSSID, RSSI).
- [x] **Audit History**: Grabación persistente de auditorías.
- [x] **CSV Export**: Exportación de datasets para análisis de datos.
- [x] **Geo-Visualization**: Mapa interactivo (OSM) con trazado de ruta en tiempo real.

---
*Desarrollado para alta precisión e ingeniería de campo.*
