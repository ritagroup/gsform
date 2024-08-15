import 'package:flutter/material.dart';
import 'package:gsform/gs_form/model/fields_model/field_model.dart';

class GSBankCardModel extends GSFieldModel {
  String? hint;

  GSBankCardModel(
      {type,
      tag,
      title,
      errorMessage,
      helpMessage,
      prefixWidget,
      postfixWidget,
      required,
      status,
      value,
      validateRegEx,
      weight,
      showTitle,
      enableReadOnly,
      this.hint})
      : super(
          type: type,
          tag: tag,
          title: title,
          errorMessage: errorMessage,
          helpMessage: helpMessage,
          prefixWidget: prefixWidget,
          postfixWidget: postfixWidget,
          required: required,
          status: status,
          showTitle: showTitle,
          value: value,
          validateRegEx: validateRegEx,
          weight: weight,
          enableReadOnly: enableReadOnly,
          focusNode: FocusNode(),
        );
}
