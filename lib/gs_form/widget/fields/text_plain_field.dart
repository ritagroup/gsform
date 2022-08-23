import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/fields_model/text_plain_model.dart';

// ignore: must_be_immutable
class GSTextPlainField extends HookWidget implements GSFieldCallBack {
  late GSTextPlainModel model;
  GSFormStyle formStyle;

  late var controller ;

  GSTextPlainField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller  = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: TextField(
        controller: controller,
        maxLines: model.maxLine,
        minLines: model.minLine ?? 3,
        keyboardType: TextInputType.multiline,
        focusNode: model.focusNode,
        maxLength: model.maxLength,
        style: formStyle.fieldTextStyle,
        textInputAction: model.nextFocusNode != null
            ? TextInputAction.next
            : TextInputAction.done,
        onSubmitted: (_) {
          FocusScope.of(context).requestFocus(model.nextFocusNode);
        },
        decoration: InputDecoration(
          hintText: model.hint,
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
