import '../../../core/app_export.dart';
/// This class is used in the Icontactinfolist_item_widgetl screen.
// ignore._for_file: must_be_immutable
class ContactinfolistItemModel {
ContactinfolistItemModel(
{this.nameOne, this.nameTwo, this.priyankareddy, this.id}) {
nameOne = nameOne ?? Rx(ImageConstant.img1828439RemovebgPreview);
nameTwo = nameTwo ?? Rx("lbl_name2".tr);
priyankareddy = priyankareddy ?? Rx("lbl_priyanka_reddy".tr);
id = id ?? Rx("");
}
Rx<String>? nameOne;
Rx<String>? nameTwo;
Rx<String>? priyankareddy;
Rx<String>? id;
}