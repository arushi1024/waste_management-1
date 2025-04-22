import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart'; // For Uri
import 'package:geolocator/geolocator.dart'; // Add this import

class MapClientScreen extends StatefulWidget {
  @override
  State<MapClientScreen> createState() => _MapClientScreenState();
}

class _MapClientScreenState extends State<MapClientScreen> {
  late final WebViewController webViewController;
  bool isMapLoaded = false;

  @override
  void initState() {
    super.initState();
    // Initialize the WebView controller
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Allow JavaScript execution
      ..enableZoom(true) // Enable zoom functionality if needed
      ..addJavaScriptChannel(
        'GeofenceChannel',
        onMessageReceived: (JavaScriptMessage message) {
          try {
            final data = jsonDecode(message.message);
            Get.snackbar(data['title'], data['message']);
          } catch (e) {
            print('Error processing message: $e');
            _showGeofenceNotification();
          }
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              isMapLoaded = true;
            });
            // When the page is loaded, get and send location
            _updateLocation();
          },
        ),
      );

    _loadHtmlFromAssets(); // Load the HTML content from assets
  }

  // Method to load HTML from assets using loadRequest
  Future<void> _loadHtmlFromAssets() async {
    final htmlString = await rootBundle.loadString('assets/map_client.html');
    final Uri dataUri = Uri.dataFromString(
      htmlString,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    );

    // Load the HTML content using loadRequest
    webViewController.loadRequest(dataUri);
  }

  // Function to get the current location and update the map
  Future<void> _updateLocation() async {
    Position? position = await getCurrentLocation();
    
    // Use default position if getting location fails
      position ??= Position(
  latitude: 12.9416,
  longitude: 77.5668,
  accuracy: 0,
  altitude: 0,
  heading: 0,
  headingAccuracy: 0,       // Required
  speed: 0,
  speedAccuracy: 0,
  altitudeAccuracy: 0,      // Required
  timestamp: DateTime.now(),
  isMocked: false,          // Also required in newer versions
);
    
    
    // Only send location to JavaScript if the map is loaded
    if (isMapLoaded) {
      _sendLocationToJavaScript(position);
    }
  }
  
  // Function to send location data to the JavaScript in WebView
  void _sendLocationToJavaScript(Position position) {
    final jsCode = """
      if (typeof map !== 'undefined' && typeof clientMarker !== 'undefined') {
        clientLocation = [${position.longitude}, ${position.latitude}];
        clientMarker.setLngLat(clientLocation);
        map.flyTo({
          center: clientLocation,
          zoom: 15,
          essential: true
        });
        
        // Also update truck position relative to new client location
        if (typeof truckMarker !== 'undefined') {
          const truckStartLongitude = clientLocation[0] + (2 / 6371) * (180 / Math.PI);
          const truckStartLatitude = clientLocation[1] + (2 / 6371) * (180 / Math.PI) / Math.cos(clientLocation[1] * (Math.PI / 180));
          truckMarker.setLngLat([truckStartLongitude, truckStartLatitude]);
          
          // Fit bounds to show both markers
          const bounds = new mapboxgl.LngLatBounds();
          bounds.extend(clientLocation);
          bounds.extend([truckStartLongitude, truckStartLatitude]);
          map.fitBounds(bounds, { padding: 100 });
        }
      }
    """;
    
    webViewController.runJavaScript(jsCode);
  }

  // Function to get current location
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    
    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Location Services Disabled', 'Please enable location services');
      return null;
    }
    
    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Permission Denied', 'Location permission is required');
        return null;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Permission Denied', 'Location permissions are permanently denied');
      return null;
    }
    
    // Get the current position
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
    } catch (e) {
      Get.snackbar('Error', 'Could not get location: $e');
      return null;
    }
  }

  // Function to show the geofence notification (fallback method)
  void _showGeofenceNotification() {
    Get.snackbar('Geofence Entered!', 'Keep your trash ready');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Client Map')),
      body: WebViewWidget(controller: webViewController),
    );
  }
}