// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/model/data_model/date_data_model.dart';
import 'package:gsform/gs_form/model/fields_model/date_range_picker_model.dart';
import 'package:gsform/gs_form/util/util.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../core/form_style.dart';

class GSDateRangePickerField extends StatefulWidget implements GSFieldCallBack {
  final GSDateRangePickerModel model;
  final GSFormStyle formStyle;

  String selectedDateText = '';
  Jalali? selectedStartDate;
  Jalali? selectedEndDate;

  DateTime? selectedGregorianStartDate;
  DateTime? selectedGregorianEndDate;
  late BuildContext context;

  late Jalali jalaliInitialStartDate;
  late Jalali jalaliInitialEndDate;
  late Jalali jalaliAvailableFrom;
  late Jalali jalaliAvailableTo;

  late DateTime gregorianInitialStartDate;
  late DateTime gregorianInitialEndDate;
  late DateTime gregorianAvailableFrom;
  late DateTime gregorianAvailableTo;

  bool isDateSelected = false;

  GSDateRangePickerField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  State<GSDateRangePickerField> createState() => _GSDateRangePickerFieldState();

  @override
  getValue() {
    return _getData();
  }

  @override
  bool isValid() {
    if (!(model.required ?? false)) {
      return true;
    } else {
      if (model.calendarType == GSCalendarType.jalali) {
        return selectedEndDate != null && selectedStartDate != null;
      } else {
        return selectedGregorianEndDate != null && selectedGregorianStartDate != null;
      }
    }
  }

  _getData() {
    if (model.calendarType == GSCalendarType.jalali) {
      return (selectedEndDate == null && selectedStartDate == null)
          ? null
          : DateDataRangeModel(
              startDateServerType: selectedStartDate!.toDateTime(),
              endDateServerType: selectedEndDate!.toDateTime(),
              startTimeStamp: selectedStartDate!.toDateTime().millisecondsSinceEpoch,
              endTimeStamp: selectedEndDate!.toDateTime().millisecondsSinceEpoch,
              displayStartDateStr: selectedDateText,
              displayEndDateStr: selectedDateText);
    } else {
      return (selectedGregorianEndDate == null && selectedGregorianStartDate == null)
          ? null
          : DateDataRangeModel(
              startDateServerType: selectedGregorianStartDate!,
              endDateServerType: selectedGregorianEndDate!,
              startTimeStamp: selectedGregorianStartDate!.millisecondsSinceEpoch,
              endTimeStamp: selectedGregorianEndDate!.millisecondsSinceEpoch,
              displayStartDateStr: selectedDateText,
              displayEndDateStr: selectedDateText);
    }
  }
}

class _GSDateRangePickerFieldState extends State<GSDateRangePickerField> {
  @override
  void initState() {
    _initialDates();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSDateRangePickerField oldWidget) {
    _initialDates();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    widget.context = context;
    return SizedBox(
      height: 48.0,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 16, bottom: 16),
        child: InkWell(
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: widget.model.dateFormatType == GSDateFormatType.numeric
                      ? Alignment.centerLeft
                      : GSFormUtils.isDirectionRTL(context)
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Text(
                    widget.selectedDateText.isEmpty ? widget.model.hint ?? '' : widget.selectedDateText,
                    style: widget.isDateSelected ? widget.formStyle.fieldTextStyle : widget.formStyle.fieldHintStyle,
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            if (widget.model.calendarType == GSCalendarType.jalali) {
              _openDateRangePicker();
            } else {
              _openGregorianDateRangePicker();
            }
          },
        ),
      ),
    );
  }

  _openDateRangePicker() async {
    var picked = await showPersianDateRangePicker(
      context: widget.context,
      initialEntryMode: PDatePickerEntryMode.calendar,
      initialDateRange: JalaliRange(
        start: widget.jalaliInitialStartDate,
        end: widget.jalaliInitialEndDate,
      ),
      firstDate: widget.jalaliAvailableFrom,
      lastDate: widget.jalaliAvailableTo,
    );
    if (picked?.start != null && picked?.end != null) {
      widget.selectedStartDate = picked?.start;
      widget.selectedEndDate = picked?.end;
      widget.jalaliInitialStartDate = picked!.start;
      widget.jalaliInitialEndDate = picked.end;
      widget.isDateSelected = true;
      _displayDate();
      update();
    } else {
      widget.isDateSelected = false;
    }
  }

  _openGregorianDateRangePicker() async {
    var picked = await showDateRangePicker(
      context: widget.context,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDateRange: DateTimeRange(
        start: widget.gregorianInitialStartDate,
        end: widget.gregorianInitialEndDate,
      ),
      firstDate: widget.gregorianAvailableFrom,
      lastDate: widget.gregorianAvailableTo,
    );
    if (picked?.start != null && picked?.end != null) {
      widget.selectedGregorianStartDate = picked?.start;
      widget.selectedGregorianEndDate = picked?.end;
      widget.gregorianInitialStartDate = picked!.start;

      widget.gregorianInitialEndDate = picked.end;
      widget.isDateSelected = true;
      _displayGregorianDate();
      update();
    } else {
      widget.isDateSelected = false;
    }
  }

  _initialDates() {
    if (widget.model.calendarType == GSCalendarType.jalali) {
      _initialJalaliDates();
    } else {
      _initialGregorianDates();
    }
  }

  _initialGregorianDates() {
    if (widget.model.initialStartDate == null) {
      widget.gregorianInitialStartDate = DateTime.now();
    } else {
      widget.gregorianInitialStartDate = DateTime(widget.model.initialStartDate!.year,
          widget.model.initialStartDate!.month, widget.model.initialStartDate!.day);
      widget.selectedGregorianStartDate = widget.gregorianInitialStartDate;
    }

    if (widget.model.initialEndDate == null) {
      widget.gregorianInitialEndDate = DateTime.now().add(const Duration(days: 2));
    } else {
      widget.gregorianInitialEndDate = DateTime(
          widget.model.initialEndDate!.year, widget.model.initialEndDate!.month, widget.model.initialEndDate!.day);
      widget.selectedGregorianEndDate = widget.gregorianInitialEndDate;
    }
    if (widget.model.initialEndDate != null && widget.model.initialStartDate != null) {
      _displayGregorianDate();
    }

    if (widget.model.availableTo == null) {
      widget.gregorianAvailableTo = DateTime(2100, 1, 1);
    } else {
      widget.gregorianAvailableTo =
          DateTime(widget.model.availableTo!.year, widget.model.availableTo!.month, widget.model.availableTo!.day);
    }

    _initialGregorianAvailableFromDate();
  }

  _initialJalaliDates() {
    if (widget.model.initialStartDate == null) {
      widget.jalaliInitialStartDate = Jalali.now();
    } else {
      widget.jalaliInitialStartDate = Jalali(widget.model.initialStartDate!.year, widget.model.initialStartDate!.month,
          widget.model.initialStartDate!.day);
      widget.selectedStartDate = widget.jalaliInitialStartDate;
      _displayDate();
    }

    if (widget.model.initialEndDate == null) {
      widget.jalaliInitialEndDate = Jalali.now().add(days: 2);
    } else {
      widget.jalaliInitialEndDate = Jalali(
          widget.model.initialEndDate!.year, widget.model.initialEndDate!.month, widget.model.initialEndDate!.day);
      widget.selectedEndDate = widget.jalaliInitialEndDate;
      _displayDate();
    }

    if (widget.model.availableTo == null) {
      widget.jalaliAvailableTo = Jalali.MAX;
    } else {
      widget.jalaliAvailableTo =
          Jalali(widget.model.availableTo!.year, widget.model.availableTo!.month, widget.model.availableTo!.day);
    }

    _initialJalaliAvailableFromDate();
  }

  _initialGregorianAvailableFromDate() {
    if (widget.model.isPastAvailable ?? false) {
      if (widget.model.availableFrom != null) {
        widget.gregorianAvailableFrom = DateTime(
            widget.model.availableFrom!.year, widget.model.availableFrom!.month, widget.model.availableFrom!.day);
      } else {
        widget.gregorianAvailableFrom = DateTime(1700, 1, 1);
      }
    } else {
      widget.gregorianAvailableFrom = widget.gregorianInitialStartDate;
    }
  }

  _initialJalaliAvailableFromDate() {
    if (widget.model.isPastAvailable ?? false) {
      if (widget.model.availableFrom != null) {
        widget.jalaliAvailableFrom = Jalali(
            widget.model.availableFrom!.year, widget.model.availableFrom!.month, widget.model.availableFrom!.day);
      } else {
        widget.jalaliAvailableFrom = Jalali.MIN;
      }
    } else {
      widget.jalaliAvailableFrom = widget.jalaliInitialStartDate;
    }
  }

  update() {
    if (mounted) {
      setState(() {});
    }
  }

  _displayDate() {
    if (widget.model.dateFormatType != null) {
      switch (widget.model.dateFormatType) {
        case GSDateFormatType.numeric:
          widget.selectedDateText =
              '${widget.model.from}: ${widget.selectedStartDate!.formatCompactDate()}  ${widget.model.to}: ${widget.selectedEndDate!.formatCompactDate()}';
          break;
        case GSDateFormatType.fullText:
          widget.selectedDateText =
              '${widget.model.from}: ${widget.selectedStartDate!.formatFullDate()}  ${widget.model.to}: ${widget.selectedEndDate!.formatFullDate()}';
          break;
        case GSDateFormatType.mediumText:
          widget.selectedDateText =
              '${widget.model.from}: ${widget.selectedStartDate!.formatMediumDate()}  ${widget.model.to}: ${widget.selectedEndDate!.formatMediumDate()}';
          break;
        case GSDateFormatType.shortText:
          widget.selectedDateText =
              '${widget.model.from}: ${widget.selectedStartDate!.formatShortDate()}  ${widget.model.to}: ${widget.selectedEndDate!.formatShortDate()}';
          break;

        default:
          widget.selectedDateText =
              '${widget.model.from}: ${widget.selectedStartDate!.formatCompactDate()}  ${widget.model.to}: ${widget.selectedEndDate!.formatCompactDate()}';
          break;
      }
    } else {
      widget.selectedDateText =
          '${widget.model.from}: ${widget.selectedStartDate!.formatCompactDate()}  ${widget.model.to}: ${widget.selectedEndDate!.formatCompactDate()}';
    }
  }

  _displayGregorianDate() {
    if (widget.model.dateFormatType != null) {
      switch (widget.model.dateFormatType) {
        case GSDateFormatType.numeric:
          widget.selectedDateText =
              '${widget.model.from}: ${DateFormat.yMd().format(widget.selectedGregorianStartDate!)}   ${widget.model.to}: ${DateFormat.yMd().format(widget.selectedGregorianEndDate!)}';
          break;
        case GSDateFormatType.fullText:
          widget.selectedDateText =
              '${widget.model.from}: ${DateFormat('EEE, MMM d, ' 'yyyy').format(widget.selectedGregorianStartDate!)}   ${widget.model.to}: ${DateFormat('EEE, MMM d, ' 'yyyy').format(widget.selectedGregorianEndDate!)}';
          break;
        case GSDateFormatType.mediumText:
          widget.selectedDateText =
              '${widget.model.from}: ${DateFormat('EEE, MMM d').format(widget.selectedGregorianStartDate!)}   ${widget.model.to}: ${DateFormat('EEE, MMM d').format(widget.selectedGregorianEndDate!)}';
          break;
        case GSDateFormatType.shortText:
          widget.selectedDateText =
              '${widget.model.from}: ${DateFormat('MMM d, ' 'yyyy').format(widget.selectedGregorianStartDate!)}   ${widget.model.to}: ${DateFormat('MMM d, ' 'yyyy').format(widget.selectedGregorianEndDate!)}';
          break;

        default:
          widget.selectedDateText =
              '${widget.model.from}: ${DateFormat.yMd().format(widget.selectedGregorianStartDate!)}   ${widget.model.to}: ${DateFormat.yMd().format(widget.selectedGregorianEndDate!)}';
          break;
      }
    } else {
      widget.selectedDateText =
          '${widget.model.from}: ${DateFormat.yMd().format(widget.selectedGregorianStartDate!)}   ${widget.model.to}: ${DateFormat.yMd().format(widget.selectedGregorianEndDate!)}';
    }
  }
}
