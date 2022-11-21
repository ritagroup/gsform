import 'package:flutter/cupertino.dart';

import '../../enums/field_status.dart';
import '../../enums/filed_type.dart';

abstract class GSFieldModel {
  GSFieldTypeEnum? type;
  String? title;
  String tag;
  String? errorMessage;
  String? helpMessage;
  Widget? prefixWidget;
  Widget? postfixWidget;
  bool? required;
  bool? showTitle;

  GSFieldStatusEnum status;

  dynamic defaultValue;
  RegExp? validateRegEx;
  int? weight;
  FocusNode? focusNode;
  FocusNode? nextFocusNode;

  GSFieldModel({
    this.type,
    required this.tag,
    this.showTitle,
    this.title,
    this.errorMessage,
    this.helpMessage,
    this.prefixWidget,
    this.postfixWidget,
    this.required,
    this.defaultValue,
    this.validateRegEx,
    this.weight,
    this.focusNode,
    this.nextFocusNode,
    GSFieldStatusEnum? status,
  }) : status = status ?? GSFieldStatusEnum.normal;
}
