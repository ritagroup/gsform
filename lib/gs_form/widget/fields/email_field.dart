import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/constant.dart';
import 'package:gsform/gs_form/core/field_callback.dart';

import '../../core/form_style.dart';
import '../../model/fields_model/email_model.dart';

class GSEmailField extends StatelessWidget implements GSFieldCallBack {
  final GSEmailModel model;
  final GSFormStyle formStyle;

  final TextEditingController? controller = TextEditingController();

  GSEmailField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: TextField(
        controller: controller,
        maxLength: model.maxLength,
        style: formStyle.fieldTextStyle,
        keyboardType: TextInputType.emailAddress,
        focusNode: model.focusNode,
        textInputAction: model.nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
        onSubmitted: (_) {
          FocusScope.of(context).requestFocus(model.nextFocusNode);
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
      if (controller!.text.isNotEmpty) {
        return RegExp(GSConstant.emailRegEx).hasMatch(controller!.text);
      }
      if (!(model.required ?? false)) {
        return true;
      }
      return controller!.text.isNotEmpty;
    }
    return model.validateRegEx!.hasMatch(controller!.text);
  }
}
