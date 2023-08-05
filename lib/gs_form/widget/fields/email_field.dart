import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/constant.dart';
import 'package:gsform/gs_form/core/field_callback.dart';

import '../../core/form_style.dart';
import '../../model/fields_model/email_model.dart';

class GSEmailField extends StatefulWidget implements GSFieldCallBack {
  final GSEmailModel model;
  final GSFormStyle formStyle;
  TextEditingController? controller;

  GSEmailField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  State<GSEmailField> createState() => _GSEmailFieldState();

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

class _GSEmailFieldState extends State<GSEmailField> {
  final TextEditingController? controller = TextEditingController();

  @override
  void initState() {
    widget.controller ??= TextEditingController();
    if (widget.model.defaultValue != null) {
      widget.controller?.text = widget.model.defaultValue;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSEmailField oldWidget) {
    if (widget.model.defaultValue != null) {
      widget.controller?.text = widget.model.defaultValue;
    }
    widget.controller = oldWidget.controller;

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.model.defaultValue != null) {
      controller?.text = widget.model.defaultValue;
    }
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: TextField(
        controller: controller,
        maxLength: widget.model.maxLength,
        style: widget.formStyle.fieldTextStyle,
        keyboardType: TextInputType.emailAddress,
        focusNode: widget.model.focusNode,
        textInputAction: widget.model.nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
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
          hintStyle: widget.formStyle.fieldHintStyle,
        ),
      ),
    );
  }
}
