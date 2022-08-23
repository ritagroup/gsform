import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';

import '../../core/form_style.dart';
import '../../model/fields_model/text_password_model.dart';

class GSPasswordField extends StatefulWidget implements GSFieldCallBack {
  late GSPasswordModel model;
  GSFormStyle formStyle;
  void Function(void Function())? state;
  bool obscured = true;

  TextEditingController? controller = TextEditingController();

  GSPasswordField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  State<GSPasswordField> createState() => _GSPasswordFieldState();

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

class _GSPasswordFieldState extends State<GSPasswordField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: TextField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: widget.obscured,
          focusNode: widget.model.focusNode,
          style: widget.formStyle.fieldTextStyle,
          controller: widget.controller,
          obscuringCharacter: '●',
          textInputAction: widget.model.nextFocusNode != null
              ? TextInputAction.next
              : TextInputAction.done,
          onSubmitted: (_) {
            FocusScope.of(context).requestFocus(widget.model.nextFocusNode);
          },
          decoration: InputDecoration(
            hintText: widget.model.hint,
            counterText: '',
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            suffixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: GestureDetector(
                onTap: () {
                  _update();
                },
                child: Icon(
                  widget.obscured
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  size: 24,
                ),
              ),
            ),
            hintStyle: widget.formStyle.fieldHintStyle,
          ),
        ),
      ),
    );
  }

  _update() {
    if (mounted) {
      setState(() => {widget.obscured = !widget.obscured});
    }
  }
  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();

  }
}
