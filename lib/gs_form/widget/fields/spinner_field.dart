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
  SpinnerDataModel ? defaultValue ;

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
    for (var element in widget.model.items) {
      if (element.isSelected ?? false) {
        widget.returnedData = element ;
        return ;
      }
    }
    if (widget.model.hint != null && widget.model.hint!.isNotEmpty && widget.hintIndex != widget.model.items[0].id) {
      widget.model.items.insert(
        0,
        SpinnerDataModel(name: widget.model.hint!, id: widget.hintIndex, data: null, isSelected: false),
      );
    }

    super.initState();
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
            value: widget.returnedData ?? widget.model.items[0],
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
                widget.returnedData = value;
                setState(() => {});
              }
            },
          ),
        ),
      ],
    );
  }
}
