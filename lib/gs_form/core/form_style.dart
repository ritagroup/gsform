import 'package:flutter/material.dart';
import 'package:gsform/gs_form/enums/filed_required_type.dart';
import 'package:gsform/gs_form/values/colors.dart';
import 'package:gsform/gs_form/values/theme.dart';

class GSFormStyle {
  TextStyle titleTextStyle;
  TextStyle fieldHintStyle;
  TextStyle fieldTextStyle;
  TextStyle errorTextStyle;
  TextStyle helpTextStyle;
  TextStyle sectionTitleStyle;
  GSFieldRequireTypeEnum requireType;
  Color backgroundFieldColor;
  Color backgroundSectionColor;
  Color fieldBorderColor;

  double fieldRadius;
  double sectionRadius;
  double sectionCardElevation;
  double sectionCardPadding;
  String requiredText;

  GSFormStyle({
    TextStyle? titleStyle,
    GSFieldRequireTypeEnum? requireType,
    Color? backgroundFieldColor,
    Color? backgroundSectionColor,
    Color? fieldBorderColor,
    double? fieldRadius,
    double? sectionRadius,
    double? sectionCardElevation,
    double? sectionCardPadding,
    TextStyle? fieldHintStyle,
    TextStyle? fieldTextStyle,
    TextStyle? errorTextStyle,
    TextStyle? helpTextStyle,
    String? requiredText,
    TextStyle? sectionTitleStyle ,
  })  : backgroundSectionColor = backgroundSectionColor ?? GSFormColors.white,
        backgroundFieldColor = backgroundFieldColor ?? GSFormColors.colorBackground,
        requireType = requireType ?? GSFieldRequireTypeEnum.star,
        titleTextStyle = titleStyle ?? GSFormTheme.textThemeStyle.headline2!,
        fieldRadius = fieldRadius ?? 10.0,
        sectionRadius = sectionRadius ?? 4.0,
        sectionCardElevation = sectionCardElevation ?? 2.0,
        sectionCardPadding = sectionCardPadding ?? 2.0,
        requiredText = requiredText ?? '(required)',
        fieldHintStyle = fieldHintStyle ?? GSFormTheme.textThemeStyle.headline2!,
        fieldTextStyle = fieldTextStyle ?? GSFormTheme.textThemeStyle.headline2!,
        errorTextStyle = errorTextStyle ?? GSFormTheme.textThemeStyle.headline5!,
        helpTextStyle = helpTextStyle ?? GSFormTheme.textThemeStyle.headline4!,
        sectionTitleStyle = sectionTitleStyle ?? GSFormTheme.textThemeStyle.headline1!,
        fieldBorderColor = fieldBorderColor ?? GSFormColors.white;

  static GSFormStyle singleSectionFormDefaultStyle = GSFormStyle(
    backgroundFieldColor: GSFormColors.white,
    sectionCardElevation: 0.0,
    backgroundSectionColor: Colors.transparent,
    sectionCardPadding: 0.0,
    titleStyle: GSFormTheme.textThemeStyle.headline2,
    fieldTextStyle: GSFormTheme.textThemeStyle.headline2,
    fieldHintStyle: GSFormTheme.textThemeStyle.headline3,
    errorTextStyle: GSFormTheme.textThemeStyle.headline5,
    helpTextStyle: GSFormTheme.textThemeStyle.headline4,
    sectionTitleStyle:GSFormTheme.textThemeStyle.headline1 ,
    sectionRadius: 8,
    fieldRadius: 8,
    fieldBorderColor: Colors.white,
  );

  static GSFormStyle singleSectionFormDefaultDarkStyle = GSFormStyle(
    backgroundFieldColor: GSFormColors.black,
    sectionCardElevation: 0.0,
    backgroundSectionColor: Colors.transparent,
    sectionCardPadding: 0.0,
    sectionTitleStyle:GSFormTheme.textThemeDarkStyle.headline1,
    titleStyle: GSFormTheme.textThemeDarkStyle.headline2,
    fieldTextStyle: GSFormTheme.textThemeDarkStyle.headline2,
    fieldHintStyle: GSFormTheme.textThemeDarkStyle.headline3,
    errorTextStyle: GSFormTheme.textThemeDarkStyle.headline5,
    helpTextStyle: GSFormTheme.textThemeDarkStyle.headline4,
    sectionRadius: 8,
    fieldRadius: 8,
    fieldBorderColor: Colors.white,
  );

  static GSFormStyle multiSectionFormDefaultStyle = GSFormStyle(
    backgroundFieldColor: GSFormColors.colorBackground,
    sectionCardElevation: 2.0,
    backgroundSectionColor: GSFormColors.white,
    sectionCardPadding: 8.0,
    titleStyle: GSFormTheme.textThemeStyle.headline2,
    fieldTextStyle: GSFormTheme.textThemeStyle.headline2,
    fieldHintStyle: GSFormTheme.textThemeStyle.headline3,
    errorTextStyle: GSFormTheme.textThemeStyle.headline5,
    helpTextStyle: GSFormTheme.textThemeStyle.headline4,
    sectionTitleStyle: GSFormTheme.textThemeStyle.headline1,
    sectionRadius: 8,
    fieldRadius: 8,
    fieldBorderColor: Colors.white,
  );

  static GSFormStyle multiSectionFormDefaultDarkStyle = GSFormStyle(
    backgroundFieldColor: GSFormColors.colorBackgroundDark,
    backgroundSectionColor: GSFormColors.black,
    titleStyle: GSFormTheme.textThemeDarkStyle.headline2,
    fieldTextStyle: GSFormTheme.textThemeDarkStyle.headline2,
    fieldHintStyle: GSFormTheme.textThemeDarkStyle.headline3,
    errorTextStyle: GSFormTheme.textThemeDarkStyle.headline5,
    helpTextStyle: GSFormTheme.textThemeDarkStyle.headline4,
    sectionTitleStyle:GSFormTheme.textThemeDarkStyle.headline1 ,
    sectionRadius: 8,
    sectionCardElevation: 2.0,
    sectionCardPadding: 8.0,
    fieldRadius: 8,
    fieldBorderColor: Colors.white,
  );
}
