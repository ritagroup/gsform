import 'package:flutter/cupertino.dart';

import '../data_model/spinner_data_model.dart';
import 'field_model.dart';

class GSSpinnerModel extends GSFieldModel {
  List<SpinnerDataModel> items;
  String? hint;
  ValueChanged<SpinnerDataModel?>? onChange;

  GSSpinnerModel(
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
      onTap,
      showTitle,
      required this.items,
      this.onChange,
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
          value: value,
          validateRegEx: validateRegEx,
          weight: weight,
          showTitle: showTitle,
        );
}
