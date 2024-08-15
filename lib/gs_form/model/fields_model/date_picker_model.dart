import 'package:gsform/gs_form/model/fields_model/field_model.dart';

import '../data_model/date_data_model.dart';

class GSDatePickerModel extends GSFieldModel {
  String? hint;
  GSDateFormatType? dateFormatType;
  bool? isPastAvailable;
  GSDate? initialDate;
  GSDate? availableFrom;
  GSDate? availableTo;
  GSCalendarType calendarType;

  GSDatePickerModel({
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
    weight,
    showTitle,
    this.hint,
    this.dateFormatType,
    this.isPastAvailable,
    this.availableFrom,
    this.availableTo,
    this.initialDate,
    required this.calendarType,
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
            weight: weight,
            showTitle: showTitle);
}
