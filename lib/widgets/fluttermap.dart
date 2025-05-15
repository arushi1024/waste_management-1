import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class TrashCollectionMap extends StatefulWidget {
  final String address;

  const TrashCollectionMap({Key? key, required this.address}) : super(key: key);

  @override
  _TrashCollectionMapState createState() => _TrashCollectionMapState();
}

class _TrashCollectionMapState extends State<TrashCollectionMap> {
  final MapController _mapController = MapController();

  final List<LatLng> _bangaloreLocations = [
    LatLng(12.9716, 77.5946), // MG Road
    LatLng(12.9352, 77.6146), // Koramangala
    LatLng(13.0358, 77.5970), // Hebbal
    LatLng(12.9260, 77.6762), // HSR Layout
    LatLng(12.9982, 77.6600), // KR Puram
    LatLng(12.9604, 77.6387), // Indiranagar
    LatLng(12.9279, 77.6271), // Jayanagar
    LatLng(13.0085, 77.5511), // Yeshwanthpur
    LatLng(12.9791, 77.5913), // Cubbon Park
  ];

  LatLng _currentLocation = LatLng(12.9716, 77.5946);
  LatLng? _truckLocation;
  List<Marker> _markers = [];

  List<LatLng> _roadPath = [];
  List<LatLng> _truckRoute = [];
  
  // Store the selected approach direction
  int _selectedDirectionIndex = 0;
  // Store the starting point for the truck
  LatLng? _selectedTruckStartPosition;

  bool _isMoving = false;
  bool _isLoading = false;
  bool _geofenceTriggered = false;
  Timer? _movementTimer;

  final Color _roadPathColor = Colors.blue.shade700;
  final Color _truckPathColor = Colors.red;
  final double _roadWidth = 5.0;
  final double _truckPathWidth = 4.0;

  @override
  void initState() {
    super.initState();
    _assignRandomLocation();
    _determinePosition();
    // Choose a random direction index when the map is first created
    _selectedDirectionIndex = Random().nextInt(4); // Four distinct path types
  }

  @override
  void dispose() {
    _movementTimer?.cancel();
    super.dispose();
  }

  void _assignRandomLocation() {
    _bangaloreLocations.shuffle();
    _currentLocation = _bangaloreLocations.first;
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location services are disabled')),
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
        
        // Initialize the truck starting position based on selected direction
        _initializeTruckStartPosition();
        
        // Generate the initial road path
        if (_selectedTruckStartPosition != null) {
          _roadPath = _generatePath(_selectedTruckStartPosition!, _currentLocation);
        }
      });
    } catch (e) {
      print("Error getting location: $e");
      _updateMarkers();
      
      // Initialize even if we couldn't get the current position
      _initializeTruckStartPosition();
      
      // Generate the initial road path
      if (_selectedTruckStartPosition != null) {
        _roadPath = _generatePath(_selectedTruckStartPosition!, _currentLocation);
      }
    }
  }

  // Initialize the truck starting position and determine the path style
  void _initializeTruckStartPosition() {
    LatLng destination = _currentLocation;
    
    // We'll create 4 completely different paths based on the selected index
    switch (_selectedDirectionIndex % 4) {
      case 0: // Standard direct path - starts from the right
        _selectedTruckStartPosition = LatLng(destination.latitude, destination.longitude + 0.02);
        break;
        
      case 1: // Circular path - starts from a nearby point and goes in a semi-circle
        _selectedTruckStartPosition = LatLng(destination.latitude - 0.015, destination.longitude - 0.015);
        break;
        
      case 2: // Detour path - starts from top and makes an indirect path
        _selectedTruckStartPosition = LatLng(destination.latitude + 0.02, destination.longitude);
        break;
        
      case 3: // Alternative route - comes from bottom left
        _selectedTruckStartPosition = LatLng(destination.latitude - 0.02, destination.longitude - 0.02);
        break;
        
      default:
        _selectedTruckStartPosition = LatLng(destination.latitude, destination.longitude + 0.02);
    }
  }

  double _calculateDistance(LatLng point1, LatLng point2) {
    return Geolocator.distanceBetween(
          point1.latitude,
          point1.longitude,
          point2.latitude,
          point2.longitude,
        ) /
        1000;
  }

  void _updateMarkers() {
    setState(() {
      _markers = [
        Marker(
          width: 120,
          height: 60,
          point: _currentLocation,
          child: Column(
            children: [
              Icon(Icons.home, size: 30, color: Colors.blue),
              Text(
                widget.address,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        if (_truckLocation != null)
          Marker(
            width: 80,
            height: 80,
            point: _truckLocation!,
            child: Column(
              children: [
                Icon(Icons.local_shipping, size: 40, color: Colors.red),
                Text("Truck", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
      ];
    });
  }

  List<LatLng> _generatePath(LatLng start, LatLng end) {
    List<LatLng> path = [];
    path.add(start);

    // Choose a completely different path generation method based on the path type
    switch (_selectedDirectionIndex % 4) {
      case 0: // Standard direct path with slight zigzag
        _generateStandardPath(path, start, end);
        break;
        
      case 1: // Circular path
        _generateCircularPath(path, start, end);
        break;
        
      case 2: // Detour path
        _generateDetourPath(path, start, end);
        break;
        
      case 3: // Alternative route with grid-like segments
        _generateAlternativePath(path, start, end);
        break;
        
      default:
        _generateStandardPath(path, start, end);
    }

    path.add(end);
    return path;
  }
  
  // Standard direct path with slight zigzag
  void _generateStandardPath(List<LatLng> path, LatLng start, LatLng end) {
    final int numWaypoints = 8;
    final double latDiff = end.latitude - start.latitude;
    final double lngDiff = end.longitude - start.longitude;
    
    for (int i = 1; i <= numWaypoints; i++) {
      double ratio = i / (numWaypoints + 1);
      
      double randomLat = (i % 2 == 0) ? 0.0008 : -0.0008;
      double randomLng = (i % 3 == 0) ? 0.0012 : -0.0006;
      
      double lat = start.latitude + (latDiff * ratio) + randomLat;
      double lng = start.longitude + (lngDiff * ratio) + randomLng;
      
      path.add(LatLng(lat, lng));
    }
  }
  
  // Circular path that arcs around to the destination
  void _generateCircularPath(List<LatLng> path, LatLng start, LatLng end) {
    final int numWaypoints = 10;
    final double centerLat = (start.latitude + end.latitude) / 2;
    final double centerLng = (start.longitude + end.longitude) / 2;
    
    // Calculate distance from center to determine radius
    final double dx = start.longitude - centerLng;
    final double dy = start.latitude - centerLat;
    final double radius = sqrt(dx * dx + dy * dy) * 1.3; // 1.3 to make it more circular
    
    // Calculate angle from start to end
    final double startAngle = atan2(start.latitude - centerLat, start.longitude - centerLng);
    final double endAngle = atan2(end.latitude - centerLat, end.longitude - centerLng);
    
    // Determine if we should go clockwise or counterclockwise
    double angleChange = endAngle - startAngle;
    if (angleChange > pi) angleChange -= 2 * pi;
    if (angleChange < -pi) angleChange += 2 * pi;
    
    for (int i = 1; i <= numWaypoints; i++) {
      double ratio = i / (numWaypoints + 1);
      double angle = startAngle + (angleChange * ratio);
      
      double lat = centerLat + (radius * sin(angle));
      double lng = centerLng + (radius * cos(angle));
      
      path.add(LatLng(lat, lng));
    }
  }
  
  // Detour path that takes an indirect route
  void _generateDetourPath(List<LatLng> path, LatLng start, LatLng end) {
    // Create a detour point that's away from the direct line
    double midLat = (start.latitude + end.latitude) / 2;
    double midLng = (start.longitude + end.longitude) / 2;
    
    // Perpendicular offset
    double dx = end.longitude - start.longitude;
    double dy = end.latitude - start.latitude;
    double length = sqrt(dx * dx + dy * dy);
    
    // Create offset point (perpendicular to direct route)
    double offsetLat = midLat + (dx / length) * 0.012;
    double offsetLng = midLng - (dy / length) * 0.012;
    LatLng detourPoint = LatLng(offsetLat, offsetLng);
    
    // First half - from start to detour point
    double latDiff1 = detourPoint.latitude - start.latitude;
    double lngDiff1 = detourPoint.longitude - start.longitude;
    
    for (int i = 1; i <= 5; i++) {
      double ratio = i / 6;
      double randomLat = (i % 2 == 0) ? 0.0006 : -0.0006;
      double randomLng = (i % 3 == 0) ? 0.0008 : -0.0004;
      
      double lat = start.latitude + (latDiff1 * ratio) + randomLat;
      double lng = start.longitude + (lngDiff1 * ratio) + randomLng;
      
      path.add(LatLng(lat, lng));
    }
    
    // Add the detour point
    path.add(detourPoint);
    
    // Second half - from detour point to end
    double latDiff2 = end.latitude - detourPoint.latitude;
    double lngDiff2 = end.longitude - detourPoint.longitude;
    
    for (int i = 1; i <= 5; i++) {
      double ratio = i / 6;
      double randomLat = (i % 2 == 0) ? 0.0006 : -0.0006;
      double randomLng = (i % 3 == 0) ? 0.0008 : -0.0004;
      
      double lat = detourPoint.latitude + (latDiff2 * ratio) + randomLat;
      double lng = detourPoint.longitude + (lngDiff2 * ratio) + randomLng;
      
      path.add(LatLng(lat, lng));
    }
  }
  
  // Alternative route with grid-like segments
  void _generateAlternativePath(List<LatLng> path, LatLng start, LatLng end) {
    // Create a path that follows a grid like city streets
    double latDiff = end.latitude - start.latitude;
    double lngDiff = end.longitude - start.longitude;
    
    // First go horizontally about 60% of the way
    LatLng point1 = LatLng(
      start.latitude, 
      start.longitude + (lngDiff * 0.6)
    );
    path.add(point1);
    
    // Then vertically about 40% of the way
    LatLng point2 = LatLng(
      start.latitude + (latDiff * 0.4),
      point1.longitude
    );
    path.add(point2);
    
    // Then horizontally to match end longitude
    LatLng point3 = LatLng(
      point2.latitude,
      end.longitude
    );
    path.add(point3);
    
    // Then diagonally to the end with a few random points
    double remainingLatDiff = end.latitude - point3.latitude;
    
    for (int i = 1; i <= 3; i++) {
      double ratio = i / 4;
      double randomFactor = 0.0004;
      double randomLat = (Random().nextDouble() * 2 - 1) * randomFactor;
      double randomLng = (Random().nextDouble() * 2 - 1) * randomFactor;
      
      double lat = point3.latitude + (remainingLatDiff * ratio) + randomLat;
      double lng = end.longitude + randomLng;
      
      path.add(LatLng(lat, lng));
    }
  }

  Future<void> _startTruckMovement() async {
    if (_isMoving) return;

    // Use the pre-selected truck start position instead of generating a new one
    if (_selectedTruckStartPosition == null) {
      _initializeTruckStartPosition();
    }
    
    LatLng truckStartPosition = _selectedTruckStartPosition!;
    LatLng destination = _currentLocation;

    setState(() {
      _truckLocation = truckStartPosition;
      _isMoving = true;
      _geofenceTriggered = false;
      _truckRoute = [];
      _updateMarkers();
    });

    // Use the pre-generated road path if available, otherwise create one
    if (_roadPath.isEmpty) {
      _roadPath = _generatePath(truckStartPosition, destination);
    }

    setState(() {
      _truckRoute = [_roadPath.first];
    });

    _mapController.fitBounds(
      LatLngBounds.fromPoints(_roadPath),
      options: FitBoundsOptions(padding: EdgeInsets.all(50)),
    );

    _animateTruckAlongPath();
  }

  void _animateTruckAlongPath() {
    final int pathPointsCount = _roadPath.length;
    int currentPathIndex = 1;

    _movementTimer?.cancel();
    _movementTimer = Timer.periodic(Duration(milliseconds: 400), (timer) {
      if (currentPathIndex >= pathPointsCount) {
        timer.cancel();
        setState(() {
          _isMoving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Truck has arrived!'),
            backgroundColor: Colors.green,
          ),
        );
        return;
      }

      setState(() {
        _truckLocation = _roadPath[currentPathIndex];
        _truckRoute.add(_truckLocation!);
        _updateMarkers();
      });

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
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app',
              ),

              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _roadPath,
                    color: _roadPathColor,
                    strokeWidth: _roadWidth,
                  ),
                ],
              ),

              // PolylineLayer(
              //   polylines: [
              //     Polyline(
              //       points: _truckRoute,
              //       color: _truckPathColor,
              //       strokeWidth: _truckPathWidth,
              //     ),
              //   ],
              // ),

              MarkerLayer(markers: _markers),
            ],
          ),

          if (_isLoading)
            Container(
              alignment: Alignment.center,
              color: Colors.black.withOpacity(0.5),
              child: CircularProgressIndicator(color: Colors.white),
            ),

          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.extended(
                  onPressed:
                      _isMoving || _isLoading ? null : _startTruckMovement,
                  icon: Icon(Icons.play_arrow),
                  label: Text('Simulate Truck Journey'),
                  backgroundColor:
                      (_isMoving || _isLoading) ? Colors.grey : Colors.green,
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
                  child: Text(
                    "Path Style: ${_getPathStyleName()}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to display the current path style name
  String _getPathStyleName() {
    switch (_selectedDirectionIndex % 4) {
      case 0: return "Standard Path";
      case 1: return "Circular Path";
      case 2: return "Detour Path";
      case 3: return "Alternative Route";
      default: return "Standard Path";
    }
  }
}