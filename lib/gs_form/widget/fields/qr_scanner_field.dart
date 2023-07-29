// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/fields_model/qr_scanner_model.dart';
import 'package:gsform/gs_form/screens/qr_scanner_screen.dart';
import 'package:gsform/gs_form/values/colors.dart';

class GSQRScannerField extends StatefulWidget implements GSFieldCallBack {
  final GSQRScannerModel model;
  final GSFormStyle formStyle;

  GSQRScannerField(this.model, this.formStyle, {Key? key}) : super(key: key);
  String? _scannedValue;

  @override
  State<GSQRScannerField> createState() => _GSQRScannerFieldState();

  @override
  getValue() {
    return _scannedValue;
  }

  @override
  bool isValid() {
    if (!(model.required ?? false)) {
      return true;
    } else {
      return _scannedValue?.isNotEmpty ?? false;
    }
  }
}

class _GSQRScannerFieldState extends State<GSQRScannerField> {
  @override
  void initState() {
    super.initState();
    widget._scannedValue = null;
  }

  @override
  void didUpdateWidget(covariant GSQRScannerField oldWidget) {
    widget._scannedValue = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onTap: () {
              _route(
                context,
                QrScannerScreen(
                  callback: (value) {
                    widget._scannedValue = value.code;
                    setState(() {});
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.model.iconWidget ?? Container(),
                  const SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: widget.model.required ?? false,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4, left: 4),
                          child: Text(
                            widget.formStyle.requiredText,
                            style: const TextStyle(
                              color: GSFormColors.red,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        widget.model.title ?? '',
                        style: widget.formStyle.titleTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  widget._scannedValue == null
                      ? Text(
                          widget.model.hint ?? '',
                          style: widget.formStyle.fieldHintStyle,
                        )
                      : Text(
                          widget._scannedValue ?? '',
                          style: widget.formStyle.fieldTextStyle,
                        ),
                ],
              ),
            )),
      ),
    );
  }

  _route(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => screen,
      ),
    );
  }
}
