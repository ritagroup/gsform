import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';

import '../../core/form_style.dart';
import '../../model/fields_model/number_model.dart';

class GSNumberField extends StatefulWidget implements GSFieldCallBack {
  final GSNumberModel model;
  final GSFormStyle formStyle;
  TextEditingController? controller ;



  GSNumberField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  State<GSNumberField> createState() => _GSNumberFieldState();

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

class _GSNumberFieldState extends State<GSNumberField> {

  @override
  void initState() {
    widget.controller ??= TextEditingController();

    if (widget.model.defaultValue != null) {
      widget.controller?.text = widget.model.defaultValue;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSNumberField oldWidget) {

    if (widget.model.defaultValue != null) {
      widget.controller?.text = widget.model.defaultValue;
    }
    widget.controller  =  oldWidget.controller;

    super.didUpdateWidget(oldWidget);

  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        maxLength: widget.model.maxLength,
        style: widget.formStyle.fieldTextStyle,
        keyboardType: TextInputType.phone,
        focusNode: widget.model.focusNode,
        textInputAction: widget.model.nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
        onSubmitted: (_) {
          FocusScope.of(context).requestFocus(widget.model.nextFocusNode);
        },
        decoration: InputDecoration(
          counter: (widget.model.showCounter ?? false) ? null : const Offstage(),
          hintText: widget.model.hint,
          counterStyle: widget.formStyle.fieldHintStyle,
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
