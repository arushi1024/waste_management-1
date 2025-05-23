//import 'package: flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'base_button.dart';
class CustomOutlinedButton extends BaseButton {
CustomOutlinedButton(
{super.key, //Key? key, 
this.decoration, this.leftIcon, this.rightIcon, this.label,
super.onPressed, super.buttonStyle, super.buttonTextStyle, super.isDisabled,
super.alignment, super.height, super.width,
super.margin, required super.text});
final BoxDecoration? decoration;
final Widget? leftIcon;
final Widget? rightIcon;
final Widget? label;
@override
Widget build(BuildContext context) {
return alignment != null
? Align(
alignment: alignment ?? Alignment.center, child: buildOutlinedButtonWidget)
: buildOutlinedButtonWidget;
}
Widget get buildOutlinedButtonWidget => Container(
height: height ?? 60.h, width: width ?? double.maxFinite, margin: margin, decoration: decoration, child: OutlinedButton ( style: buttonStyle,
onPressed: isDisabled ?? false ? null : onPressed ?? () {}, child: Row(
mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
children: [
leftIcon ?? const SizedBox.shrink(),
Text(
text,
style: buttonTextStyle ?? theme.textTheme.headlineMedium,),
rightIcon ?? const SizedBox.shrink()
],
),
),
) ;
}