import 'package:gsform/gs_form/model/data_model/date_data_model.dart';
import 'package:gsform/gs_form/model/fields_model/field_model.dart';

class GSDateRangePickerModel extends GSFieldModel {
  String? hint;
  GSDateFormatType? dateFormatType;
  bool? isPastAvailable;
  GSDate? initialStartDate;
  GSDate? initialEndDate;
  GSDate? availableFrom;
  GSDate? availableTo;
  GSCalendarType calendarType;
  String? from;
  String? to;

  GSDateRangePickerModel({
    type,
    tag,
    title,
    errorMessage,
    helpMessage,
    showTitle,
    prefixWidget,
    postfixWidget,
    required,
    status,
    value,
    validateReg,
    weight,
    this.hint,
    this.dateFormatType,
    this.isPastAvailable,
    this.availableFrom,
    this.availableTo,
    this.initialStartDate,
    this.initialEndDate,
    required this.calendarType,
    this.from,
    this.to,
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
            showTitle: showTitle);
}
