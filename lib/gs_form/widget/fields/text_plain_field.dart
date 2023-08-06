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
    if (widget.model.defaultValue != null) {
      widget.controller?.text = widget.model.defaultValue;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSTextPlainField oldWidget) {
    widget.controller = oldWidget.controller;
    // if (widget.model.defaultValue != null) {
    //   widget.controller?.text = widget.model.defaultValue;
    // }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
      child: TextField(
        readOnly: widget.model.enableReadOnly??false,
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
        decoration: InputDecoration(
          counter: widget.model.showCounter ?? false ? null : const Offstage(),
          hintText: widget.model.hint,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          counterStyle: widget.formStyle.fieldHintStyle,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: widget.formStyle.fieldHintStyle,
        ),
      ),
    );
  }
}
