// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:intl/intl.dart';

import '../../core/form_style.dart';
import '../../model/fields_model/price_model.dart';

class GSPriceField extends StatefulWidget implements GSFieldCallBack {
  late GSPriceModel model;
  GSFormStyle formStyle;
  TextEditingController? controller;

  GSPriceField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  State<GSPriceField> createState() => _GSPriceFieldState();

  @override
  getValue() {
    return controller!.text.replaceAll(',', '');
  }

  @override
  bool isValid() {
    if (model.validateRegEx == null) {
      if (!(model.required ?? false)) {
        return true;
      } else {
        return controller!.text.isNotEmpty;
      }
    } else {
      return model.validateRegEx!.hasMatch(controller!.text);
    }
  }

  String _formatNumber(String s) => NumberFormat.decimalPattern().format(int.parse(s));
}

class _GSPriceFieldState extends State<GSPriceField> {
  @override
  void initState() {
    widget.controller ??= TextEditingController();
    if (widget.model.defaultValue != null) {
      widget.model.defaultValue = widget._formatNumber(widget.model.defaultValue.replaceAll(',', ''));
      widget.controller?.value = TextEditingValue(
        text: widget.model.defaultValue,
        selection: TextSelection.collapsed(offset: widget.model.defaultValue.length),
      );
      widget.controller?.text = widget.model.defaultValue;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSPriceField oldWidget) {

    if (widget.model.defaultValue != null) {
      widget.controller?.text = widget.model.defaultValue;
    }else {
      widget.controller = oldWidget.controller;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: TextField(
        readOnly: widget.model.enableReadOnly ?? false,
        controller: widget.controller,
        maxLength: widget.model.maxLength,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.left,
        focusNode: widget.model.focusNode,
        style: widget.formStyle.fieldTextStyle,
        textInputAction: widget.model.nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
        onSubmitted: (_) {
          FocusScope.of(context).requestFocus(widget.model.nextFocusNode);
        },
        onChanged: (string) {
          string = widget._formatNumber(string.replaceAll(',', ''));
          widget.controller!.value = TextEditingValue(
            text: string,
            selection: TextSelection.collapsed(offset: string.length),
          );
        },
        decoration: InputDecoration(
          hintText: widget.model.hint,
          counterText: '',
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: widget.formStyle.fieldHintStyle,
        ),
      ),
    );
  }
}
