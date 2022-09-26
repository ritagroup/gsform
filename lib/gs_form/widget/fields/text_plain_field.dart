import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/fields_model/text_plain_model.dart';

class GSTextPlainField extends StatelessWidget implements GSFieldCallBack {
  final GSTextPlainModel model;
  final GSFormStyle formStyle;

  final TextEditingController? controller = TextEditingController();

  GSTextPlainField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.value != null) {
      controller?.text = model.value;
    }
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
      child: TextField(
        controller: controller,
        maxLines: model.maxLine,
        minLines: model.minLine ?? 3,
        keyboardType: TextInputType.multiline,
        focusNode: model.focusNode,
        maxLength: model.maxLength,
        style: formStyle.fieldTextStyle,
        textInputAction: model.nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
        onSubmitted: (_) {
          FocusScope.of(context).requestFocus(model.nextFocusNode);
        },
        decoration: InputDecoration(
          counter: model.showCounter ?? false ? null : const Offstage(),
          hintText: model.hint,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          counterStyle: formStyle.fieldHintStyle,
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
