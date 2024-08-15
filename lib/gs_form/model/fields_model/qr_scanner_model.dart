import 'package:flutter/cupertino.dart';
import 'package:gsform/gs_form/model/fields_model/field_model.dart';

class GSQRScannerModel extends GSFieldModel {
  String? hint;
  Widget? iconWidget;

  GSQRScannerModel({
    type,
    tag,
    title,
    errorMessage,
    helpMessage,
    required,
    status,
    weight,
    showTitle,
    enableReadOnly,
    this.hint,
    this.iconWidget,
  }) : super(
          type: type,
          tag: tag,
          title: title,
          errorMessage: errorMessage,
          helpMessage: helpMessage,
          required: required,
          status: status,
          weight: weight,
          showTitle: showTitle,
          enableReadOnly: enableReadOnly,
        );
}
