import 'package:flutter/material.dart';

import 'field_model.dart';

class GSTimePickerModel extends GSFieldModel {
  String? hint;
  TimeOfDay? initialTime;

  GSTimePickerModel({
    type,
    tag,
    title,
    errorMessage,
    helpMessage,
    prefixWidget,
    postfixWidget,
    required,
    status,
    value,
    validateReg,
    weight,

    showTitle,
    this.hint,
    this.initialTime,
  }) : super(
          type: type,
          tag: tag,
          title: title,
          errorMessage: errorMessage,
          helpMessage: helpMessage,
          prefixWidget: prefixWidget,
          postfixWidget: postfixWidget,
          required: required,
          status: status,
          value: value,
          validateRegEx: validateReg,
          weight: weight,
          showTitle: showTitle,
        );
}
