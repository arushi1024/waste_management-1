import 'package:flutter/material.dart'; 
import '../../../core/app_export.dart';
import '../controller/frame_seventeen_controller.dart'; 
import '../models/contactinfolist_item_model.dart';
// ignore_for_file: must_be_immutable
class ContactinfolistItemWidget extends StatelessWidget {
ContactinfolistItemWidget(this.contactinfolistItemModelObj, {Key? key})
: super (
key: key,
);
ContactinfolistItemModel contactinfolistItemModelObj;
var controller = Get.find<FrameSeventeenController>();
@override
Widget build(BuildContext context) {
return Padding (
padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 16.h), child: Row( 
  crossAxisAlignment: CrossAxisAlignment.start, children: [
Obx (
() => CustomImageView(
imagePath: contactinfolistItemModelObj.nameOne!.value, height: 58.h, width: 58.h,
) ,
),
SizedBox(width: 12.h,),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,  children: [
Obx(
() => Text(
contactinfolistItemModelObj.nameTwo!.value, style: theme.textTheme.bodyMedium, maxLines: 1,overflow: TextOverflow.clip,
),
),
Obx (
() => Text(
contactinfolistItemModelObj.priyankareddy!.value, style: CustomTextStyles.bodyMediumInter15,maxLines: 1,overflow: TextOverflow.clip,
),
)
],
),
),
],
),
);
}
}