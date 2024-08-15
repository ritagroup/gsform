// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/data_model/date_data_model.dart';
import 'package:gsform/gs_form/util/util.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../model/fields_model/date_picker_model.dart';

class GSDatePickerField extends StatefulWidget implements GSFieldCallBack {
  late GSDatePickerModel model;
  final GSFormStyle formStyle;
  Function(DateTime?)? onChanged;

  String selectedDateText = '';
  Jalali? selectedJalaliDate;
  DateTime? selectedGregorianDate;
  late BuildContext context;

  late Jalali jalaliInitialDate;
  late Jalali jalaliAvailableFrom;
  late Jalali jalaliAvailableTo;

  late DateTime gregorianInitialDate;
  late DateTime gregorianAvailableFrom;
  late DateTime gregorianAvailableTo;

  bool isDateSelected = false;

  GSDatePickerField(this.model, this.formStyle, this.onChanged, {Key? key}) : super(key: key);

  @override
  State<GSDatePickerField> createState() => _GSDatePickerFieldState();

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
        return selectedJalaliDate != null;
      } else {
        return selectedGregorianDate != null;
      }
    }
  }

  _getData() {
    if (model.calendarType == GSCalendarType.jalali) {
      return selectedJalaliDate == null
          ? null
          : DateDataModel(
              dateServerType: selectedJalaliDate!.toDateTime(),
              timeStamp: selectedJalaliDate!.toDateTime().millisecondsSinceEpoch,
              showDateStr: selectedDateText);
    } else {
      return selectedGregorianDate == null
          ? null
          : DateDataModel(
              dateServerType: selectedGregorianDate!, timeStamp: selectedGregorianDate!.millisecondsSinceEpoch, showDateStr: selectedDateText);
    }
  }
}

class _GSDatePickerFieldState extends State<GSDatePickerField> {
  @override
  void initState() {
    _initialDates();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSDatePickerField oldWidget) {
    if (widget.model.calendarType == GSCalendarType.jalali) {
      if (oldWidget.selectedJalaliDate != null) {
        widget.model.initialDate = GSDate(
            year: oldWidget.selectedJalaliDate!.year,
            month: oldWidget.selectedJalaliDate!.month,
            day: oldWidget.selectedJalaliDate!.day);
      }
    } else {
      if (oldWidget.selectedGregorianDate != null) {
        widget.model.initialDate = GSDate(
            year: oldWidget.selectedGregorianDate!.year,
            month: oldWidget.selectedGregorianDate!.month,
            day: oldWidget.selectedGregorianDate!.day);
      }
    }
    _initialDates();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    widget.context = context;
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 18, bottom: 18),
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
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if (widget.model.calendarType == GSCalendarType.jalali) {
          _openDatePicker();
        } else {
          _openGregorianPicker();
        }
      },
    );
  }

  _initialDates() {
    if (widget.model.calendarType == GSCalendarType.jalali) {
      _initialJalaliDates();
    } else {
      _initialGregorianDates();
    }
  }

  _initialGregorianDates() {
    if (widget.model.initialDate == null) {
      widget.gregorianInitialDate = DateTime.now();
    } else {
      widget.gregorianInitialDate = DateTime(widget.model.initialDate!.year, widget.model.initialDate!.month, widget.model.initialDate!.day);
      widget.selectedGregorianDate = widget.gregorianInitialDate;
      _displayGregorianDate();
    }

    if (widget.model.availableTo == null) {
      widget.gregorianAvailableTo = DateTime(2100, 1, 1);
    } else {
      widget.gregorianAvailableTo = DateTime(widget.model.availableTo!.year, widget.model.availableTo!.month, widget.model.availableTo!.day);
    }

    _initialGregorianAvailableFromDate();
  }

  _initialJalaliDates() {
    if (widget.model.initialDate == null) {
      widget.jalaliInitialDate = Jalali.now();
    } else {
      widget.jalaliInitialDate = Jalali(widget.model.initialDate!.year, widget.model.initialDate!.month, widget.model.initialDate!.day);
      widget.selectedJalaliDate = widget.jalaliInitialDate;
      _displayDate();
    }

    if (widget.model.availableTo == null) {
      widget.jalaliAvailableTo = Jalali.MAX;
    } else {
      widget.jalaliAvailableTo = Jalali(widget.model.availableTo!.year, widget.model.availableTo!.month, widget.model.availableTo!.day);
    }

    _initialJalaliAvailableFromDate();
  }

  _initialGregorianAvailableFromDate() {
    if (widget.model.isPastAvailable ?? false) {
      if (widget.model.availableFrom != null) {
        widget.gregorianAvailableFrom =
            DateTime(widget.model.availableFrom!.year, widget.model.availableFrom!.month, widget.model.availableFrom!.day);
      } else {
        widget.gregorianAvailableFrom = DateTime(1700, 1, 1);
      }
    } else {
      widget.gregorianAvailableFrom = widget.gregorianInitialDate;
    }
  }

  _initialJalaliAvailableFromDate() {
    if (widget.model.isPastAvailable ?? false) {
      if (widget.model.availableFrom != null) {
        widget.jalaliAvailableFrom = Jalali(widget.model.availableFrom!.year, widget.model.availableFrom!.month, widget.model.availableFrom!.day);
      } else {
        widget.jalaliAvailableFrom = Jalali.MIN;
      }
    } else {
      widget.jalaliAvailableFrom = widget.jalaliInitialDate;
    }
  }

  _openDatePicker() async {
    Jalali? picked = await showPersianDatePicker(
      context: widget.context,
      initialDate: widget.jalaliInitialDate,
      firstDate: widget.jalaliAvailableFrom,
      lastDate: widget.jalaliAvailableTo,
    );
    if (picked != null) {
      widget.selectedJalaliDate = picked;
      widget.jalaliInitialDate = picked;
      widget.isDateSelected = true;
      _displayDate();
      update();
    } else {
      widget.isDateSelected = false;
    }
  }

  _openGregorianPicker() async {
    DateTime? picked = await showDatePicker(
      context: widget.context,
      initialDate: widget.gregorianInitialDate,
      firstDate: widget.gregorianAvailableFrom,
      lastDate: widget.gregorianAvailableTo,
    );
    if (picked != null) {
      widget.selectedGregorianDate = picked;
      widget.isDateSelected = true;
      widget.gregorianInitialDate = picked;
      _displayGregorianDate();
      update();
    } else {
      widget.isDateSelected = false;
    }
    widget.onChanged?.call(picked);
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
          widget.selectedDateText = widget.selectedJalaliDate!.formatCompactDate();
          break;
        case GSDateFormatType.fullText:
          widget.selectedDateText = widget.selectedJalaliDate!.formatFullDate();
          break;
        case GSDateFormatType.mediumText:
          widget.selectedDateText = widget.selectedJalaliDate!.formatMediumDate();
          break;
        case GSDateFormatType.shortText:
          widget.selectedDateText = widget.selectedJalaliDate!.formatShortDate();
          break;
        default:
          widget.selectedDateText = widget.selectedJalaliDate!.formatCompactDate();
          break;
      }
    } else {
      widget.selectedDateText = widget.selectedJalaliDate!.formatCompactDate();
    }
  }

  _displayGregorianDate() {
    if (widget.model.dateFormatType != null) {
      switch (widget.model.dateFormatType) {
        case GSDateFormatType.numeric:
          widget.selectedDateText = DateFormat.yMd().format(widget.selectedGregorianDate!);
          break;
        case GSDateFormatType.fullText:
          widget.selectedDateText = DateFormat('EEE, MMM d, ' 'yyyy').format(widget.selectedGregorianDate!);
          break;
        case GSDateFormatType.mediumText:
          widget.selectedDateText = DateFormat('EEE, MMM d').format(widget.selectedGregorianDate!);
          break;
        case GSDateFormatType.shortText:
          widget.selectedDateText = DateFormat('MMM d, ' 'yyyy').format(widget.selectedGregorianDate!);
          break;
        default:
          widget.selectedDateText = DateFormat.yMd().format(widget.selectedGregorianDate!);
          break;
      }
    } else {
      widget.selectedDateText = DateFormat.yMd().format(widget.selectedGregorianDate!);
    }
  }
}
