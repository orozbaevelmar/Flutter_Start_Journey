import 'package:flutter/material.dart';
import 'package:start_journey/cleanArch/core/theme/app_color.dart';

class StartJourneyTheme extends ChangeNotifier {
  static const defaultScreenWidth = 393.0;
  static const defaultScreenHeight = 853.0;

  var _screenScaleFactor = 1.0;

  void setScreenScaleFactor(double? currentScreenWidth) {
    _screenScaleFactor = currentScreenWidth != null
        ? currentScreenWidth / defaultScreenWidth
        : _screenScaleFactor;

    notifyListeners();
  }

  double scaledSize(double size) => size * _screenScaleFactor;

  Radius scaledRadius(double radius) =>
      Radius.circular(radius * _screenScaleFactor);

  ThemeData get appTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: "BeVietnamPro",
      primaryColor: AppColor.greenPrimary,
      colorScheme: ColorScheme.light(primary: AppColor.greenPrimary),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: LGStrong.copyWith(color: AppColor.black),
        ),
      ),
    );
  }

  TextStyle get heading4 => TextStyle(
        fontSize: scaledSize(20),
        fontWeight: FontWeight.w600,
        height: scaledSize(28 / 20),
      );

  TextStyle get heading3 => TextStyle(
        fontSize: scaledSize(24),
        fontWeight: FontWeight.w600,
        height: scaledSize(32 / 24),
      );

  TextStyle get heading2 => TextStyle(
        fontSize: scaledSize(30),
        fontWeight: FontWeight.w600,
        height: scaledSize(38 / 30),
      );

  // ignore: non_constant_identifier_names
  TextStyle get XLStrong => TextStyle(
        fontSize: scaledSize(20),
        fontWeight: FontWeight.w600,
        height: scaledSize(28 / 20),
      );

  TextStyle get miniNormal => TextStyle(
        fontSize: scaledSize(12),
        fontWeight: FontWeight.w400,
        height: scaledSize(22 / 14),
        letterSpacing: scaledSize(0.12),
      );

  TextStyle get baseNormal =>
      TextStyle(fontSize: scaledSize(14), fontWeight: FontWeight.w400);

  TextStyle get baseStrong => TextStyle(
        fontSize: scaledSize(14),
        fontWeight: FontWeight.w600,
        height: scaledSize(22 / 14),
      );

  TextStyle get smallMedium => TextStyle(
        fontSize: scaledSize(14),
        fontWeight: FontWeight.w500,
        height: scaledSize(22 / 14),
      );

  TextStyle get navBarTitleTextStyle => TextStyle(
        fontSize: scaledSize(14),
        fontWeight: FontWeight.w700,
        height: scaledSize(22 / 14),
        color: AppColor.greenPrimary,
      );

  // ignore: non_constant_identifier_names
  TextStyle get LGStrong => TextStyle(
        fontSize: scaledSize(16),
        fontWeight: FontWeight.w600,
        height: scaledSize(24 / 16),
      );
  // ignore: non_constant_identifier_names
  TextStyle get LGMiddle => TextStyle(
        fontSize: scaledSize(16),
        fontWeight: FontWeight.w500,
        height: scaledSize(24 / 16),
      );

  // ignore: non_constant_identifier_names
  TextStyle get LGNormal => TextStyle(
        fontSize: scaledSize(16),
        fontWeight: FontWeight.w400,
        height: scaledSize(24 / 16),
      );

  // ignore: non_constant_identifier_names
  TextStyle get linkTextStyle => TextStyle(
        fontSize: scaledSize(16),
        fontWeight: FontWeight.w900,
        height: scaledSize(24 / 16),
      );

  // ignore: non_constant_identifier_names
  TextStyle get tag => TextStyle(
        fontSize: scaledSize(15),
        fontWeight: FontWeight.w600,
        height: 1,
      );

  // ignore: non_constant_identifier_names
  TextStyle get info => TextStyle(
        fontSize: scaledSize(16),
        fontWeight: FontWeight.w600,
        height: 1.2,
      );

  // ignore: non_constant_identifier_names
  TextStyle get label => TextStyle(
        fontSize: scaledSize(14),
        fontWeight: FontWeight.w500,
        height: 1.2,
      );

  // ignore: non_constant_identifier_names
  TextStyle get nav => TextStyle(
        fontSize: scaledSize(16),
        fontWeight: FontWeight.w600,
        height: 1,
      );

  TextStyle get cardLabel =>
      TextStyle(fontSize: scaledSize(20), fontWeight: FontWeight.w700);

  TextStyle get body => TextStyle(
        fontSize: scaledSize(16),
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  /// 4.0
  double get paddingXXS => scaledSize(4.0);

  /// 8.0
  double get paddingXS => paddingXXS * 2;

  /// 12.0
  double get paddingS => paddingXXS * 3;

  /// 16.0
  double get paddingM => paddingXXS * 4;

  /// 20.0
  double get paddingL => paddingXXS * 5;

  /// 24.0
  double get paddingXL => paddingXXS * 6;

  /// 28.0
  double get paddingXXL => paddingXXS * 7;

  /// 32.0
  double get paddingXXXL => paddingXXS * 8;

  InputDecoration inputDecoration(
    String labelText, [
    Color? fillColor,
    Color? borderColor,
  ]) =>
      InputDecoration(
        labelText: labelText,
        counterText: '',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: LGNormal.copyWith(color: AppColor.black),
        errorStyle: baseNormal.copyWith(color: AppColor.errorColor),
        contentPadding: EdgeInsets.symmetric(
          vertical: paddingXS,
          horizontal: paddingS,
        ),
        filled: true,
        fillColor: fillColor ?? AppColor.gradient1.withAlpha(25),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(scaledRadius(12)),
          borderSide: BorderSide(
            color: borderColor ?? AppColor.greenPrimary.withAlpha(255 ~/ 4),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(scaledRadius(12)),
          borderSide: BorderSide(
            color: borderColor ?? AppColor.greenPrimary.withAlpha(255 ~/ 4),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(scaledRadius(12)),
          borderSide: BorderSide(color: AppColor.errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(scaledRadius(12)),
          borderSide: BorderSide(color: AppColor.errorColor, width: 1),
        ),
      );
}
