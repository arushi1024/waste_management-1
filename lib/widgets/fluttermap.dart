import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class TrashCollectionMap extends StatefulWidget {
  @override
  _TrashCollectionMapState createState() => _TrashCollectionMapState();
}

class _TrashCollectionMapState extends State<TrashCollectionMap> {
  final MapController _mapController = MapController();

  // Default location (Bangalore)
  LatLng _currentLocation = LatLng(12.9416, 77.5668);
  LatLng? _truckLocation;
  List<Marker> _markers = [];
  
  // Route visualization
  List<LatLng> _roadPath = [];
  List<LatLng> _truckRoute = [];
  
  bool _isMoving = false;
  bool _isLoading = false;
  bool _geofenceTriggered = false;
  Timer? _movementTimer;

  // Colors for visualization
  final Color _roadPathColor = Colors.blue.shade700;
  final Color _truckPathColor = Colors.red;
  final double _roadWidth = 5.0;
  final double _truckPathWidth = 4.0;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  void dispose() {
    _movementTimer?.cancel();
    super.dispose();
  }

  // Get current position with permission handling
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location services are disabled'))
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied')),
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _updateMarkers();
        _mapController.move(_currentLocation, 14);
      });
    } catch (e) {
      print("Error getting location: $e");
      // Use default location
      _updateMarkers();
    }
  }

  // Calculate distance in kilometers
  double _calculateDistance(LatLng point1, LatLng point2) {
    return Geolocator.distanceBetween(
          point1.latitude,
          point1.longitude,
          point2.latitude,
          point2.longitude,
        ) / 1000; // Convert meters to kilometers
  }

  // Update markers on the map
  void _updateMarkers() {
    setState(() {
      _markers = [
        // User location marker
        Marker(
          width: 120,
          height: 60,
          point: _currentLocation,
          child: Column(
            children: [
              Icon(
                Icons.home,
                size: 30,
                color: Colors.blue,
              ),
              Text("Your Location", style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
        
        // Truck marker
        if (_truckLocation != null)
          Marker(
            width: 80,
            height: 80,
            point: _truckLocation!,
            child: Column(
              children: [
                Icon(
                  Icons.local_shipping,
                  size: 40,
                  color: Colors.red,
                ),
                Text("Truck", style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
      ];
    });
  }

  // Get route between two points using OpenRouteService API
  Future<List<LatLng>> _getRoutePath(LatLng start, LatLng end) async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      // For demonstration, we'll generate a realistic-looking path
      // In a real app, you would use an API like OpenRouteService, GraphHopper, or MapBox
      List<LatLng> simulatedPath = _generateSimulatedRoadPath(start, end);
      
      setState(() {
        _isLoading = false;
      });
      
      return simulatedPath;
    } catch (e) {
      print("Error getting route: $e");
      setState(() {
        _isLoading = false;
      });
      
      // Return a straight line as fallback
      return [start, end];
    }
  }
  
  // Generate a simulated road path with curves for demonstration
  List<LatLng> _generateSimulatedRoadPath(LatLng start, LatLng end) {
    List<LatLng> path = [];
    path.add(start);
    
    // Create waypoints to simulate a road with curves
    final int numWaypoints = 8;
    
    final double latDiff = end.latitude - start.latitude;
    final double lngDiff = end.longitude - start.longitude;
    
    // Add some randomness to make it look like a road
    for (int i = 1; i <= numWaypoints; i++) {
      double ratio = i / (numWaypoints + 1);
      
      // Create slight random deviations to simulate roads
      double randomLat = (i % 2 == 0) ? 0.0008 : -0.0008;
      double randomLng = (i % 3 == 0) ? 0.0012 : -0.0006;
      
      double lat = start.latitude + (latDiff * ratio) + randomLat;
      double lng = start.longitude + (lngDiff * ratio) + randomLng;
      
      path.add(LatLng(lat, lng));
    }
    
    path.add(end);
    return path;
  }

  // Start truck movement animation along road path
  Future<void> _startTruckMovement() async {
    if (_isMoving) return;

    // Initialize truck position (2km away from user)
    final double offsetLat = 0.018; // ~2km in latitude
    final double offsetLng = 0.018; // ~2km in longitude
    LatLng truckStartPosition = LatLng(
      _currentLocation.latitude + offsetLat,
      _currentLocation.longitude + offsetLng,
    );
    
    setState(() {
      _truckLocation = truckStartPosition;
      _isMoving = true;
      _geofenceTriggered = false;
      _truckRoute = [];
      _updateMarkers();
    });
    
    // Get the road path
    _roadPath = await _getRoutePath(truckStartPosition, _currentLocation);
    
    setState(() {
      // Add the first point of the truck's traveled path
      _truckRoute = [_roadPath.first];
    });

    // Move the map to show the entire route
    _mapController.fitBounds(
      LatLngBounds.fromPoints(_roadPath),
      options: FitBoundsOptions(padding: EdgeInsets.all(50)),
    );

    // Animate truck along the path
    _animateTruckAlongPath();
  }
  
  void _animateTruckAlongPath() {
    // Animation parameters
    final int pathPointsCount = _roadPath.length;
    int currentPathIndex = 1; // Start from second point (index 1)
    
    // Create animation timer
    _movementTimer?.cancel();
    _movementTimer = Timer.periodic(Duration(milliseconds: 400), (timer) {
      if (currentPathIndex >= pathPointsCount) {
        timer.cancel();
        setState(() {
          _isMoving = false;
        });
        
        // Show completion message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Truck has arrived!'),
            backgroundColor: Colors.green,
          ),
        );
        return;
      }

      setState(() {
        // Update truck position to next point in path
        _truckLocation = _roadPath[currentPathIndex];
        
        // Add point to truck's traveled route
        _truckRoute.add(_truckLocation!);
        
        _updateMarkers();
      });

      // Check if truck entered geofence (1km)
      if (!_geofenceTriggered) {
        double distance = _calculateDistance(_currentLocation, _truckLocation!);
        if (distance <= 1.0) {
          _geofenceTriggered = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Truck is nearby! Keep your trash ready.'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }

      currentPathIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trash Collection Tracker'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _currentLocation,
              zoom: 14.0,
              maxZoom: 18.0,
              minZoom: 3.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app',
              ),
              
              // Draw the road path first (underneath)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _roadPath,
                    color: _roadPathColor,
                    strokeWidth: _roadWidth,
                  ),
                ],
              ),
              
              // Draw the truck's traveled path on top
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _truckRoute,
                    color: _truckPathColor,
                    strokeWidth: _truckPathWidth,
                  ),
                ],
              ),
              
              MarkerLayer(markers: _markers),
            ],
          ),
          
          // Loading indicator
          if (_isLoading)
            Container(
              alignment: Alignment.center,
              color: Colors.black.withOpacity(0.5),
              child: CircularProgressIndicator(color: Colors.white),
            ),
          
          // Action buttons
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.extended(
                  onPressed: _isMoving || _isLoading ? null : _startTruckMovement,
                  icon: Icon(Icons.play_arrow),
                  label: Text('Simulate Truck Journey'),
                  backgroundColor: (_isMoving || _isLoading) ? Colors.grey : Colors.green,
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 4,
                                color: _roadPathColor,
                              ),
                              SizedBox(width: 8),
                              Text("Road Path"),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 4,
                                color: _truckPathColor,
                              ),
                              SizedBox(width: 8),
                              Text("Truck Route"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}