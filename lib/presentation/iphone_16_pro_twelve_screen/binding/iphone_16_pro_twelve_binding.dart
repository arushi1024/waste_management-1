import '../../../core/app_export.dart';
import '../controller/iphone_16_pro_twelve_controller.dart';
/// A binding class for the Iphonel6ProTwelveScreen.
///
/// This class ensures that the Iphonel6ProTwelveController is created when the /// Iphone16ProTwelveScreen is first loaded. 
class Iphone16ProTwelveBinding extends Bindings {
@override
void dependencies () {
Get.lazyPut(() => Iphone16ProTwelveController());
}
}