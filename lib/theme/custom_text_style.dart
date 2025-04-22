import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }
  TextStyle get kaiseiTokumin{
    return copyWith(fontFamily: 'Kaisei Tokumin',);
  }
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}

/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body text style
  static TextStyle get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.31),
      );

  static TextStyle get bodyLargeInterOnError =>
      theme.textTheme.bodyLarge!.inter.copyWith(
        color: theme.colorScheme.onError,
        fontSize: 16.5,
      );

  static TextStyle get bodyLargeInterOnSecondaryContainer =>
      theme.textTheme.bodyLarge!.inter.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
        fontSize: 16.5,
      );

  static TextStyle get bodyLargeInterSecondaryContainer =>
      theme.textTheme.displayMedium!.kaiseiTokumin.copyWith(
        fontWeight: FontWeight.w700
      );
  static TextStyle get displayMediumKaiseiTokumin =>
      theme.textTheme.bodyLarge!.inter.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontSize: 16.5,
      );

  static TextStyle get bodyMedium14 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 14.5,
      );

  static TextStyle get bodyMediumRobotoBlack900 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.black900.withOpacity(0.5),
        fontSize: 14.5,
      );

  // Display text style
  static TextStyle get displayMediumOnPrimaryContainer =>
      theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );

  // Headline text style
  static TextStyle get headlineLarge32 =>
      theme.textTheme.headlineLarge!.copyWith(
        fontSize: 32.5,
      );

  static TextStyle get headlineMediumBlack900 =>
      theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 26.5,
      );

  static TextStyle get headlineMediumBlack90026 =>
      theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 26.5,
      );

  static TextStyle get headlineMediumBlack900_1 =>
      theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.black900,
      );

  static TextStyle get headlineMediumBlack900_2 =>
      theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.black900,
      );
  static TextStyle get bodyMediumInter15=>
      theme.textTheme.bodyMedium!.inter.copyWith(
        fontSize:15.fSize,
      );

  static TextStyle get headlineMediumBlack900_3 =>
      theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.black900,
      );

  static TextStyle get headlineMediumOnPrimaryContainer =>
      theme.textTheme.headlineMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );

  // Title text style
  static TextStyle get titleLargeGray900 =>
      theme.textTheme.titleLarge!.copyWith(
        color: appTheme.gray900,
      );
    static TextStyle get headlineSmallBlack900=> theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleLargeOnPrimaryContainer =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
}
