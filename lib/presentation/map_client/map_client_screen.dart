import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart'; // For Uri

class MapClientScreen extends StatefulWidget {
  @override
  State<MapClientScreen> createState() => _MapClientScreenState();
}

class _MapClientScreenState extends State<MapClientScreen> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    // Initialize the WebView controller
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Allow JavaScript execution
      ..enableZoom(true) // Enable zoom functionality if needed
      ..addJavaScriptChannel('GeofenceChannel', 
      onMessageReceived: 
      (JavaScriptMessage message)
      {if (message.message == 'geofence_entered')
      {_showGeofenceNotification();
      }
      },);

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

  // Function to show the geofence notification
  void _showGeofenceNotification() { // Handle your notification logic here
    Get.snackbar('Geofence Entered!', 'Keep your trash ready');
    // You can use any notification plugin like `flutter_local_notifications` here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Client Map')),
      body: WebViewWidget(controller: webViewController), // Display the WebView
    );
  }
}
