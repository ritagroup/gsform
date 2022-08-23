import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gsform/gs_form/core/field_callback.dart';

import '../../core/form_style.dart';
import '../../model/fields_model/number_model.dart';

// ignore: must_be_immutable
class GSNumberField extends HookWidget implements GSFieldCallBack {
  late GSNumberModel model;
  GSFormStyle formStyle;

  late var controller ;

  GSNumberField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller = useTextEditingController() ;
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: TextField(
        controller: controller,
        maxLength: model.maxLength,
        style: formStyle.fieldTextStyle,
        keyboardType: TextInputType.phone,
        focusNode: model.focusNode,
        textInputAction: model.nextFocusNode != null
            ? TextInputAction.next
            : TextInputAction.done,
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
      if (!(model.required ?? false)) {
        return true;
      } else {
        return controller!.text.isNotEmpty;
      }
    } else {
      return model.validateRegEx!.hasMatch(controller!.text);
    }
  }
}
