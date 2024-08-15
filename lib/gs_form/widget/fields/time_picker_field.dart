// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/data_model/time_data_model.dart';
import 'package:gsform/gs_form/model/fields_model/time_picker_model.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class GSTimePickerField extends StatefulWidget implements GSFieldCallBack {
  late GSTimePickerModel model;
  GSFormStyle formStyle;
  Function(TimeOfDay?)? onChanged;

  String? selectedTimeText;

  bool isTimeSelected = false;
  TimeOfDay? selectedTime;
  late BuildContext context;

  GSTimePickerField(this.model, this.formStyle, this.onChanged, {Key? key}) : super(key: key) {
    selectedTimeText = model.hint ?? 'Select a time';
  }

  @override
  State<GSTimePickerField> createState() => _GSTimePickerFieldState();

  @override
  getValue() {
    return _provideData(context);
  }

  @override
  bool isValid() {
    if (!(model.required ?? false)) {
      return true;
    } else {
      if (selectedTime == null) {
        return false;
      } else {
        return true;
      }
    }
  }

  _provideData(BuildContext context) {
    return selectedTime == null
        ? null
        : TimeDataModel(displayTime: selectedTime!.format(context), hour: selectedTime!.hour, minute: selectedTime!.minute);
  }
}

class _GSTimePickerFieldState extends State<GSTimePickerField> {
  @override
  void initState() {
    super.initState();
    if (widget.model.initialTime != null) {
      widget.selectedTime = widget.model.initialTime;
      widget.isTimeSelected = true;
      _displayTime(widget.selectedTime!);
    }
  }

  @override
  void didUpdateWidget(covariant GSTimePickerField oldWidget) {
    if (widget.model.initialTime != null && oldWidget.selectedTime == null) {
      widget.selectedTime = widget.model.initialTime;
    } else {
      widget.selectedTime = oldWidget.selectedTime;
      widget.selectedTimeText = oldWidget.selectedTimeText;
      widget.selectedTimeText = oldWidget.selectedTimeText;
    }
    widget.isTimeSelected = true;
    _displayTime(widget.selectedTime!);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    widget.context = context;
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 16, bottom: 16),
      child: InkWell(
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.selectedTimeText!,
                style: widget.isTimeSelected ? widget.formStyle.fieldTextStyle : widget.formStyle.fieldHintStyle,
              ),
            ),
          ],
        ),
        onTap: () {
          if (widget.model.timePickerType == TimePickerType.persian) {
            _openPersianTimePicker();
          } else {
            _openTimePicker();
          }
        },
      ),
    );
  }

  _openPersianTimePicker() async {
    var picked = await showPersianTimePicker(
      context: widget.context,
      initialTime: widget.selectedTime ?? TimeOfDay.now(),
      initialEntryMode: PTimePickerEntryMode.dial,
      useRootNavigator: false,
    );
    if (picked != null) {
      widget.selectedTime = picked;
      widget.model.initialTime = picked;
      widget.isTimeSelected = true;
      _displayTime(picked);
      update();
    } else {
      widget.isTimeSelected = false;
    }
  }

  _openTimePicker() async {
    var picked = await showTimePicker(
      context: widget.context,
      initialTime: widget.selectedTime ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      useRootNavigator: false,
    );
    if (picked != null) {
      widget.selectedTime = picked;
      widget.model.initialTime = picked;
      widget.isTimeSelected = true;
      _displayTime(picked);
      update();
    } else {
      widget.isTimeSelected = false;
    }
    widget.onChanged?.call(picked);
  }

  update() {
    if (mounted) {
      setState(() {});
    }
  }

  _displayTime(TimeOfDay time) {
    String hour = time.hour.toString().length == 1 ? '0${time.hour}' : time.hour.toString();
    String minute = time.minute.toString().length == 1 ? '0${time.minute}' : time.minute.toString();
    widget.selectedTimeText = '$hour:$minute';
  }
}
