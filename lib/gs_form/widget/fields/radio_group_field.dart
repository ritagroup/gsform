import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/data_model/radio_data_model.dart';
import 'package:gsform/gs_form/model/fields_model/radio_model.dart';

import '../../core/field_callback.dart';

// ignore: must_be_immutable
class GSRadioGroupField extends StatefulWidget implements GSFieldCallBack {
  final GSRadioModel model;


  final GSFormStyle? formStyle;

  GSRadioGroupField(this.model, this.formStyle, {Key? key}) : super(key: key);

  RadioDataModel? valueObject;

  @override
  State<GSRadioGroupField> createState() => _GSRadioGroupFieldState();

  @override
  getValue() {
    return valueObject ?? '';
  }

  @override
  bool isValid() {
    if (!(model.required ?? false)) {
      return true;
    } else {
      return valueObject != null;
    }
  }
}

class _GSRadioGroupFieldState extends State<GSRadioGroupField> {

  @override
  void initState() {
    super.initState();
  }





  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: widget.model.height,
      child: RawScrollbar(
        thumbColor: widget.model.scrollBarColor?? Colors.blue,
        trackRadius: const Radius.circular(6),
        radius: const Radius.circular(6),
        interactive: true,
        trackVisibility: true,
        thumbVisibility: true,
        thickness:widget.model.showScrollBar??false?6:0,


        child: ListView.builder(
          itemCount: widget.model.items.length,
          shrinkWrap: widget.model.scrollable == null ? false : !widget.model.scrollable!,
          physics: !widget.model.scrollable! ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  for (var element in widget.model.items) {
                    element.isSelected = false;
                  }
                  widget.model.items[index].isSelected = true;
                  widget.model.callBack(widget.model.items[index]);
                  widget.valueObject = widget.model.items[index];
                  setState(() => {});
                  setState(() {});
                },
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4),
                  child: RadioItem(widget.model.items[index], widget.model, widget.formStyle!),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioDataModel _item;
  final GSFormStyle formStyle;
  final GSRadioModel _model;

  const RadioItem(this._item, this._model, this.formStyle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  _model.unSelectedIcon == null
                      ? Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        )
                      : _model.unSelectedIcon!,
                  Visibility(
                    visible: _item.isSelected,
                    child: _model.selectedIcon == null
                        ? Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          )
                        : _model.selectedIcon!,
                  )
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  _item.title,
                  style: formStyle.fieldHintStyle,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
