
import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/data_model/spinner_data_model.dart';
import 'package:gsform/gs_form/model/fields_model/spinner_model.dart';

class GSSpinnerField extends StatefulWidget implements GSFieldCallBack {
  final hintIndex = -1;

  GSSpinnerModel model;
  GSFormStyle formStyle;

  SpinnerDataModel? value;

  GSSpinnerField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  State<GSSpinnerField> createState() => _GSSpinnerFieldState();

  @override
  getValue() {
    return value?.name ?? model.items[0].name;
  }

  @override
  bool isValid() {
    if (model.required != null && model.required!) {
      if (value?.id == -1 || value == null) {
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
    if (widget.model.hint != null && widget.model.hint!.isNotEmpty && widget.hintIndex != widget.model.items[0].id) {
      widget.model.items.insert(
        0,
        SpinnerDataModel(name: widget.model.hint!, id: widget.hintIndex),
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
              padding: EdgeInsets.only(left: 6.0, right: 6.0),
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 20,
              ),
            ),
            isExpanded: true,
            value: widget.value ?? widget.model.items[0],
            items: widget.model.items
                .map((e) =>
                DropdownMenuItem(
                    value: e,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: 8.0),
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
                widget.value = value;
                setState(() => {});
              }
            },
          ),
        ),
      ],
    );
  }
}
