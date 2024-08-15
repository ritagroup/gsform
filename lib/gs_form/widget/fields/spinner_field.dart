// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/data_model/spinner_data_model.dart';
import 'package:gsform/gs_form/model/fields_model/spinner_model.dart';

class GSSpinnerField extends StatefulWidget implements GSFieldCallBack {
  final hintIndex = -1;

  GSSpinnerModel model;
  GSFormStyle formStyle;
  SpinnerDataModel? returnedData;

  GSSpinnerField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  State<GSSpinnerField> createState() => _GSSpinnerFieldState();

  @override
  getValue() {
    return returnedData;
  }

  @override
  bool isValid() {
    if (model.required != null && model.required!) {
      if (returnedData?.id == -1 || returnedData == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}

class _GSSpinnerFieldState extends State<GSSpinnerField> {
  @override
  void initState() {
    if (widget.model.items.isNotEmpty) {
      for (var element in widget.model.items) {
        if (element.isSelected ?? false) {
          widget.returnedData = element;
        }
      }

      if (widget.returnedData == null) {
        widget.returnedData = widget.model.items[0];
      }

      if (widget.model.hint != null && widget.model.hint!.isNotEmpty && widget.hintIndex != widget.model.items[0].id) {
        widget.model.items.insert(
          0,
          SpinnerDataModel(name: widget.model.hint!, id: widget.hintIndex, data: null, isSelected: false),
        );
      }
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSSpinnerField oldWidget) {
    widget.returnedData = null;
    for (var element in widget.model.items) {
      if (element.isSelected ?? false) {
        widget.returnedData = element;
        return;
      }
    }
    if (oldWidget.returnedData != null) {
      for (var element in widget.model.items) {
        if (widget.returnedData == null) {
          if (element.id == oldWidget.returnedData!.id) {
            element.isSelected = true;
            widget.returnedData = element;
          } else {
            element.isSelected = false;
          }
        }
        super.didUpdateWidget(oldWidget);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<SpinnerDataModel>(
              underline: const SizedBox(),
              iconSize: 0,
              icon: const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                ),
              ),
              isExpanded: true,
              value: widget.returnedData,
              items: widget.model.items
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        child: Text(
                          e.name,
                          style: e.id == widget.hintIndex
                              ? widget.formStyle.fieldHintStyle
                              : widget.formStyle.fieldTextStyle,
                        ),
                      )))
                  .toList(),
              onChanged: (value) {
                if (value?.id != widget.hintIndex) {
                  widget.model.items.firstWhere((element) => element.id == value!.id).isSelected = true;
                  value?.isSelected = true;
                  widget.returnedData = value;
                  widget.model.onChange?.call(value);
                  setState(() => {});
                }
              }),
        ),
      ],
    );
  }
}
