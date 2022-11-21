import 'package:flutter/cupertino.dart';

import 'field_model.dart';

class GSPasswordModel extends GSFieldModel {
  int? maxLength;
  String? hint;

  GSPasswordModel(
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
      validateReg,
      weight,
      showTitle,
      this.maxLength,
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
          defaultValue: value,
          validateRegEx: validateReg,
          weight: weight,
          focusNode: FocusNode(),
          showTitle: showTitle,
        );
}
