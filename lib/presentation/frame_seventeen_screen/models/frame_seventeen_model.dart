import '../../../core/app_export.dart'; 
import 'contactinfolist_item_model.dart';
/// This class defines the variables used in the frame_seventeen_screen],
// and is typically used to hold data that is passed between different parts of the application
// ignore_for_file: must_be_immutable
class FrameSeventeenModel {
Rx<List<ContactinfolistItemModel>> contactinfolistItemList = Rx([
ContactinfolistItemModel(
nameOne: ImageConstant.img1828439RemovebgPreview.obs, nameTwo: "lbl_name2".tr.obs,
priyankareddy: "lbl_priyanka_reddy".tr.obs) ,
ContactinfolistItemModel(
nameOne: ImageConstant.imgImageRemovebgPreview12.obs, 
nameTwo: "lbl_email_id".tr.obs,
priyankareddy: "msg_pripri_gmail_com".tr.obs)
]);
}