import 'dart:ui';

import 'package:gsform/gs_form/model/fields_model/field_model.dart';

class GSQRScannerModel extends GSFieldModel {
  String? hint;
  String iconAsset;
  Color? iconColor;

  GSQRScannerModel(
      {type,
      tag,
      title,
      errorMessage,
      helpMessage,
      required,
      status,
      weight,
      showTitle,
      this.hint,
      required this.iconAsset,
      this.iconColor})
      : super(
          type: type,
          tag: tag,
          title: title,
          errorMessage: errorMessage,
          helpMessage: helpMessage,
          required: required,
          status: status,
          weight: weight,
          showTitle: showTitle,
        );
}
