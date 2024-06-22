import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/fields_model/text_plain_model.dart';

// ignore: must_be_immutable
class GSTextPlainField extends StatefulWidget implements GSFieldCallBack {
  final GSTextPlainModel model;
  final GSFormStyle formStyle;
  TextEditingController? controller;

  GSTextPlainField(this.model, this.formStyle, {Key? key}) : super(key: key);

  @override
  State<GSTextPlainField> createState() => _GSTextPlainFieldState();

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

class _GSTextPlainFieldState extends State<GSTextPlainField> {
  @override
  void initState() {
    widget.controller ??= TextEditingController();
    if (widget.model.value != null) {
      widget.controller?.text = widget.model.value;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSTextPlainField oldWidget) {
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
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
      child: TextField(
        readOnly: widget.model.enableReadOnly ?? false,
        controller: widget.controller,
        minLines: widget.model.minLine,
        enableSuggestions: false,
        autocorrect: false,
        maxLines: widget.model.maxLine,
        keyboardType: TextInputType.multiline,
        focusNode: widget.model.focusNode,
        maxLength: widget.model.maxLength,
        style: widget.formStyle.fieldTextStyle,
        textInputAction: TextInputAction.newline,
        onSubmitted: (_) {
          FocusScope.of(context).requestFocus(widget.model.nextFocusNode);
        },
        onChanged: widget.model.onChanged,
        decoration: InputDecoration(
          hintText: widget.model.hint,
          errorText: (!widget.isValid()) && (widget.controller?.text??'').length>0 ? widget.model.errorMessage:null,
          helperText: widget.model.helpMessage,
          labelText: widget.model.title,
          counter: widget.model.showCounter ?? false ? null : const Offstage(),
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

      ),

    );
  }
}
