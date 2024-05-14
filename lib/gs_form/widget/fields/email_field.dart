import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/constant.dart';
import 'package:gsform/gs_form/core/field_callback.dart';

import '../../core/form_style.dart';
import '../../model/fields_model/email_model.dart';

// ignore: must_be_immutable
class GSEmailField extends StatefulWidget implements GSFieldCallBack {
  final GSEmailModel model;
  final GSFormStyle formStyle;
  TextEditingController? controller = TextEditingController();

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
  @override
  void initState() {
    widget.controller ??= TextEditingController();
    if (widget.model.value != null) {
      widget.controller?.text = widget.model.value;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSEmailField oldWidget) {
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
    if (widget.model.value != null) {
      widget.controller?.text = widget.model.value;
    }
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: TextField(
        readOnly: widget.model.enableReadOnly ?? false,
        controller: widget.controller,
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
