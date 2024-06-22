import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/fields_model/mobile_model.dart';

// ignore: must_be_immutable
class GSMobileField extends StatefulWidget implements GSFieldCallBack {
  final GSMobileModel model;
  final GSFormStyle formStyle;
  TextEditingController? controller;

  GSMobileField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  State<GSMobileField> createState() => _GSMobileFieldState();

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

class _GSMobileFieldState extends State<GSMobileField> {
  @override
  void initState() {
    widget.controller ??= TextEditingController();

    if (widget.model.value != null) {
      widget.controller?.text = widget.model.value;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSMobileField oldWidget) {
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
      controller: widget.controller,
      maxLength: widget.model.maxLength,
      style: widget.formStyle.fieldTextStyle,
      keyboardType: TextInputType.phone,
      focusNode: widget.model.focusNode,
      textInputAction: widget.model.nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
      onSubmitted: (_) {
        FocusScope.of(context).requestFocus(widget.model.nextFocusNode);
      },
      onChanged: widget.model.onChanged,
      decoration: InputDecoration(
        hintText: widget.model.hint,
        errorText: (!widget.isValid()) && (widget.controller?.text??'').length>0 ? widget.model.errorMessage:null,
        helperText: widget.model.helpMessage,
        labelText: widget.model.title,
        counterText: '',
        suffixIcon: widget.model.postfixWidget,
        prefixIcon: widget.model.prefixWidget,
        hintStyle: widget.formStyle.fieldHintStyle,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.formStyle.backgroundFieldColorDisable ,width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(
              widget.formStyle.fieldRadius,
            ),
          ),
        ),
        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: widget.formStyle.fieldBorderColor ,width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(
              widget.formStyle.fieldRadius,
            ),
          ),
        ),
        focusedBorder:OutlineInputBorder(
          borderSide: BorderSide(color: widget.formStyle.fieldBorderColor ,width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(
              widget.formStyle.fieldRadius,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: widget.formStyle.fieldBorderColor ,width: 1 ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              widget.formStyle.fieldRadius,
            ),
          ),
        ),

      ),
    );
  }
}
