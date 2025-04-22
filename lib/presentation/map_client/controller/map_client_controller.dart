// lib/presentation/map_client/controller/map_client_controller.dart

import 'package:get/get.dart';
import '../models/map_client_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapClientController extends GetxController {
  Rx<MapClientModel> mapClientModel = MapClientModel().obs;
  late final WebViewController webViewController;

  void setWebViewController(WebViewController controller) {
    webViewController = controller;
  }
}
