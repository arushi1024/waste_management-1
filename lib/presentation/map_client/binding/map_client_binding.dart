// lib/presentation/map_client/binding/map_client_binding.dart

import 'package:get/get.dart';
import '../controller/map_client_controller.dart';

class MapClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapClientController());
  }
}
