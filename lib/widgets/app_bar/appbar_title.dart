//import 'package: flutter/material.dart';
import 'package:flutter/widgets.dart'; 
import '../../core/app_export.dart';
class AppbarTitle extends StatelessWidget {
const AppbarTitle({super.key, required this.text, this.onTap, this.margin});
final String text;
final Function? onTap;
final EdgeInsetsGeometry? margin;
@override
Widget build(BuildContext context) {
return Padding(
padding: margin ?? EdgeInsets.zero, child: GestureDetector(
onTap: () {
onTap?.call();
},
child: Container (
decoration: AppDecoration.outlineBlack, child: Text( text, textAlign: TextAlign.left, style: theme.textTheme.displayMedium!.copyWith(
color: appTheme.black900,
),
),
),
),
);
}
}
