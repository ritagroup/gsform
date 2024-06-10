import 'package:flutter/cupertino.dart';

import 'field_model.dart';

class GSTextModel extends GSFieldModel {
  int? maxLength;
  ValueChanged<String>? onChanged;

  String? hint;

  GSTextModel({
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
    validateRegEx,
    weight,
    showTitle,
    enableReadOnly,
    onTap,
    focusNode,
    nextFocusNode,
    this.maxLength,
    this.hint,
    this.onChanged,
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
          validateRegEx: validateRegEx,
          weight: weight,
          focusNode: focusNode,
          nextFocusNode: nextFocusNode,
          showTitle: showTitle,
          enableReadOnly: enableReadOnly,
          onTap: onTap,
        );
}
