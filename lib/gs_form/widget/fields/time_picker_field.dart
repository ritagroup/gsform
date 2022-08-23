import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/data_model/time_data_model.dart';
import 'package:gsform/gs_form/model/fields_model/time_picker_model.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

// ignore: must_be_immutable
class GSTimePickerField extends StatefulWidget implements GSFieldCallBack {
  late GSTimePickerModel model;
  GSFormStyle formStyle;

  String? selectedTimeText;

  bool isTimeSelected = false;
  TimeOfDay? selectedTime;
  late BuildContext context ;

  GSTimePickerField(this.model, this.formStyle, {Key? key}) : super(key: key) {
    selectedTimeText = model.hint ?? 'زمان را انتخاب کنید';
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
        : TimeDataModel(
            displayTime: selectedTime!.format(context),
            hour: selectedTime!.hour,
            minute: selectedTime!.minute);
  }


}

class _GSTimePickerFieldState extends State<GSTimePickerField> {
  @override
  Widget build(BuildContext context) {
    widget.context = context  ;
    return SizedBox(
      height: 35.0,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: InkWell(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.selectedTimeText!,
                  style: widget.isTimeSelected
                      ? widget.formStyle.fieldTextStyle
                      : widget.formStyle.fieldHintStyle,
                ),
              ),
            ],
          ),
          onTap: () {
            _openTimePicker();
          },
        ),
      ),
    );
  }

  _openTimePicker() async {
    var picked = await showPersianTimePicker(
      context: widget.context,
      initialTime: widget.model.initialTime ?? TimeOfDay.now(),
      initialEntryMode: PTimePickerEntryMode.dial,
    );
    if (picked != null) {
      String hour = picked.hour.toString().length == 1
          ? '0${picked.hour}'
          : picked.hour.toString();
      String minute = picked.minute.toString().length == 1
          ? '0${picked.minute}'
          : picked.minute.toString();
      widget.selectedTimeText = '$hour:$minute';
      widget.selectedTime = picked;
      widget.isTimeSelected = true;
      update();
    } else {
      widget.isTimeSelected = false;
    }
  }

  update() {
    if (mounted) {
      setState(() {});
    }
  }

}
