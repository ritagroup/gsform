// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';

import '../../core/form_style.dart';
import '../../model/fields_model/text_password_model.dart';

class GSPasswordField extends StatefulWidget implements GSFieldCallBack {
  late GSPasswordModel model;
  GSFormStyle formStyle;
  void Function(void Function())? state;
  bool obscured = true;

  TextEditingController? controller;

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
  void initState() {
    widget.controller ??= TextEditingController();

    if (widget.model.value != null) {
      widget.controller?.text = widget.model.value;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSPasswordField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.model.value == widget.model.value) {
      widget.controller = oldWidget.controller;
    } else {
      widget.controller ??= TextEditingController();
      widget.controller!.text = widget.model.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.model.enableReadOnly ?? false,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: TextInputType.visiblePassword,
      obscureText: widget.obscured,
      focusNode: widget.model.focusNode,
      style: widget.formStyle.fieldTextStyle,
      controller: widget.controller,
      obscuringCharacter: '●',
      textInputAction: widget.model.nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
      onSubmitted: (_) {
        FocusScope.of(context).requestFocus(widget.model.nextFocusNode);
      },
      onChanged: widget.model.onChanged,
      decoration: InputDecoration(
        hintText: widget.model.hint,
        errorText: (!widget.isValid()) ? widget.model.errorMessage : null,
        helperText: widget.model.helpMessage,
        labelText: widget.model.title,
        counterText: '',
        prefixIcon: widget.model.prefixWidget,
        hintStyle: widget.formStyle.fieldHintStyle,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.formStyle.fieldBorderColor, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.0,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: widget.formStyle.fieldBorderColor, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.0,
            ),
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            _update();
          },
          child: Icon(
            widget.obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded,
          ),
        ),
      ),
    );
  }

  _update() {
    if (mounted) {
      setState(() => widget.obscured = !widget.obscured);
    }
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }
}
