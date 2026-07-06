import 'package:employee_support_system/core/resources/font_sizes.dart';
import 'package:employee_support_system/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(
  double fontSize,
  String? fontFamily,
  FontWeight fontWeight,
  Color color, {
  double height = 1.3,
  double letterSpacing = 0.5,
}) => TextStyle(
  fontSize: fontSize,
  fontFamily: fontFamily ?? FontConstants.interFontFamily,
  color: color,
  fontWeight: fontWeight,
  height: height,
  letterSpacing: letterSpacing,
);

TextStyle getLightStyle({
  double? fontSize,
  String? fontFamily,
  required Color color,
}) => _getTextStyle(
  fontSize ?? FontSize.s12,
  fontFamily,
  FontWeightManager.light,
  color,
);

TextStyle getRegularStyle({
  double? fontSize,
  String? fontFamily,
  required Color color,
}) => _getTextStyle(
  fontSize ?? FontSize.s12,
  fontFamily,
  FontWeightManager.regular,
  color,
);

TextStyle getMediumStyle({
  double? fontSize,
  String? fontFamily,
  required Color color,
}) => _getTextStyle(
  fontSize ?? FontSize.s12,
  fontFamily,
  FontWeightManager.medium,
  color,
);

TextStyle getSemiBoldStyle({
  double? fontSize,
  String? fontFamily,
  required Color color,
}) => _getTextStyle(
  fontSize ?? FontSize.s12,
  fontFamily,
  FontWeightManager.semiBold,
  color,
);

TextStyle getBoldStyle({
  double? fontSize,
  String? fontFamily,
  required Color color,
}) => _getTextStyle(
  fontSize ?? FontSize.s12,
  fontFamily,
  FontWeightManager.bold,
  color,
);

TextStyle getTextWithLine() => TextStyle(
  color: ColorManager.primary,
  fontSize: FontSize.s12,
  fontWeight: FontWeight.w400,
  decoration: TextDecoration.lineThrough,
  decorationColor: ColorManager.primary,
);
