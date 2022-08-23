// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/data_model/date_data_model.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../model/fields_model/date_picker_model.dart';

class GSDatePickerField extends StatefulWidget implements GSFieldCallBack {
  late GSDatePickerModel model;
  final GSFormStyle formStyle;

  String selectedDateText = '';
  Jalali? selectedJalaliDate;

  DateTime? selectedGregorianDate;

  late BuildContext context ;

  GSDatePickerField(this.model, this.formStyle, {Key? key}) : super(key: key);

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
              timeStamp: selectedJalaliDate!.toDateTime().microsecondsSinceEpoch,
              showDateStr: selectedDateText);
    } else {
      return selectedGregorianDate == null
          ? null
          : DateDataModel(
              dateServerType: selectedGregorianDate!,
              timeStamp: selectedGregorianDate!.microsecondsSinceEpoch,
              showDateStr: selectedDateText);
    }
  }
}

class _GSDatePickerFieldState extends State<GSDatePickerField> {
  late Jalali jalaliInitialDate;
  late Jalali jalaliAvailableFrom;
  late Jalali jalaliAvailableTo;

  late DateTime gregorianInitialDate;
  late DateTime gregorianAvailableFrom;
  late DateTime gregorianAvailableTo;

  bool isDateSelected = false;

  @override
  void initState() {
    _initialDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.context = context ;
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0 , top: 22 , bottom: 22),
      child: InkWell(
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.selectedDateText.isEmpty ? widget.model.hint ?? '' : widget.selectedDateText,
                style: isDateSelected ? widget.formStyle.fieldTextStyle : widget.formStyle.fieldHintStyle,
              ),
            ),
          ],
        ),
        onTap: () {
          if (widget.model.calendarType == GSCalendarType.jalali) {
            _openDatePicker();
          } else {
            _openGregorianPicker();
          }
        },
      ),
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
      gregorianInitialDate = DateTime.now();
    } else {
      gregorianInitialDate =
          DateTime(widget.model.initialDate!.year, widget.model.initialDate!.month, widget.model.initialDate!.day);
    }

    if (widget.model.availableTo == null) {
      gregorianAvailableTo = DateTime(2100, 1, 1);
    } else {
      gregorianAvailableTo =
          DateTime(widget.model.availableTo!.year, widget.model.availableTo!.month, widget.model.availableTo!.day);
    }

    _initialGregorianAvailableFromDate();
  }

  _initialJalaliDates() {
    if (widget.model.initialDate == null) {
      jalaliInitialDate = Jalali.now();
    } else {
      jalaliInitialDate =
          Jalali(widget.model.initialDate!.year, widget.model.initialDate!.month, widget.model.initialDate!.day);
    }

    if (widget.model.availableTo == null) {
      jalaliAvailableTo = Jalali.MAX;
    } else {
      jalaliAvailableTo =
          Jalali(widget.model.availableTo!.year, widget.model.availableTo!.month, widget.model.availableTo!.day);
    }

    _initialJalaliAvailableFromDate();
  }

  _initialGregorianAvailableFromDate() {
    if (widget.model.isPastAvailable ?? false) {
      if (widget.model.availableFrom != null) {
        gregorianAvailableFrom = DateTime(
            widget.model.availableFrom!.year, widget.model.availableFrom!.month, widget.model.availableFrom!.day);
      } else {
        gregorianAvailableFrom = DateTime(1700, 1, 1);
      }
    } else {
      gregorianAvailableFrom = gregorianInitialDate;
    }
  }

  _initialJalaliAvailableFromDate() {
    if (widget.model.isPastAvailable ?? false) {
      if (widget.model.availableFrom != null) {
        jalaliAvailableFrom = Jalali(
            widget.model.availableFrom!.year, widget.model.availableFrom!.month, widget.model.availableFrom!.day);
      } else {
        jalaliAvailableFrom = Jalali.MIN;
      }
    } else {
      jalaliAvailableFrom = jalaliInitialDate;
    }
  }

  _openDatePicker() async {
    Jalali? picked = await showPersianDatePicker(
      context: widget.context,
      initialDate: jalaliInitialDate,
      firstDate: jalaliAvailableFrom,
      lastDate: jalaliAvailableTo,
    );
    if (picked?.formatCompactDate() != null) {
      widget.selectedJalaliDate = picked;
      isDateSelected = true;
      _displayDate();
      update();
    } else {
      isDateSelected = false;
    }
  }

  _openGregorianPicker() async {
    DateTime? picked = await showDatePicker(
      context: widget.context,
      initialDate: gregorianInitialDate,
      firstDate: gregorianAvailableFrom,
      lastDate: gregorianAvailableTo,
    );
    if (picked != null) {
      widget.selectedGregorianDate = picked;
      isDateSelected = true;
      _displayGregorianDate();
      update();
    } else {
      isDateSelected = false;
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
