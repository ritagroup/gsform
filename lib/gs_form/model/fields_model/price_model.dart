import 'package:flutter/cupertino.dart';

import 'field_model.dart';

class GSPriceModel extends GSFieldModel {
  int? maxLength;

  String? hint;

  GSPriceModel(
      {type,
      tag,
      title,
      errorMessage,
      helpMessage,
      prefixWidget,
      postfixWidget,
      required,
      status,
      defaultValue,
      validateRegEx,
      maxLength,
      weight,
      showTitle,
      enableReadOnly,
      onTap,
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
          defaultValue: defaultValue,
          validateRegEx: validateRegEx,
          weight: weight,
          focusNode: FocusNode(),
          showTitle: showTitle,
          enableReadOnly: enableReadOnly,
          onTap: onTap,
        );
}
