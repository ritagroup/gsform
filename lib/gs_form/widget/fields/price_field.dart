// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:intl/intl.dart';

import '../../core/form_style.dart';
import '../../model/fields_model/price_model.dart';

class GSPriceField extends StatelessWidget implements GSFieldCallBack {
  late GSPriceModel model;
  GSFormStyle formStyle;

  final TextEditingController? controller = TextEditingController();

  GSPriceField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.defaultValue != null) {
      controller?.text = model.defaultValue;
    }
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: TextField(
        controller: controller,
        maxLength: model.maxLength,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        focusNode: model.focusNode,
        style: formStyle.fieldTextStyle,
        textInputAction: model.nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
        onSubmitted: (_) {
          FocusScope.of(context).requestFocus(model.nextFocusNode);
        },
        onChanged: (string) {
          string = _formatNumber(string.replaceAll(',', ''));
          controller!.value = TextEditingValue(
            text: string,
            selection: TextSelection.collapsed(offset: string.length),
          );
        },
        decoration: InputDecoration(
          hintText: model.hint,
          counterText: '',
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: formStyle.fieldHintStyle,
        ),
      ),
    );
  }

  @override
  getValue() {
    return controller!.text;
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
