import 'package:flutter/cupertino.dart';

import 'field_model.dart';

class GSTextPlainModel extends GSFieldModel {
  int? maxLength;
  int? maxLine;
  int? minLine;
  String? hint;
  bool? showCounter;

  GSTextPlainModel(
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
      enableReadOnly,
      weight,
      showTitle,
      onTap,
      this.minLine,
      this.maxLength,
      this.maxLine,
      this.hint,
      this.showCounter})
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
          value: value,
          validateRegEx: validateRegEx,
          weight: weight,
          focusNode: FocusNode(),
          showTitle: showTitle,
          enableReadOnly: enableReadOnly,
          onTap: onTap,
        );
}
