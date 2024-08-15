import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/data_model/radio_data_model.dart';
import 'package:gsform/gs_form/model/fields_model/radio_model.dart';
import 'package:gsform/gs_form/values/colors.dart';

import '../../core/field_callback.dart';

// ignore: must_be_immutable
class GSRadioGroupField extends StatefulWidget implements GSFieldCallBack {
  final GSRadioModel model;
  final GSFormStyle? formStyle;
  TextEditingController textController = TextEditingController();

  GSRadioGroupField(this.model, this.formStyle, {Key? key}) : super(key: key);

  RadioDataModel? returnedData;
  List<RadioDataModel> filteredItems = [];
  String keyword = "";

  @override
  State<GSRadioGroupField> createState() => _GSRadioGroupFieldState();

  @override
  getValue() {
    return returnedData;
  }

  @override
  bool isValid() {
    if (!(model.required ?? false)) {
      return true;
    } else {
      return returnedData != null;
    }
  }
}

class _GSRadioGroupFieldState extends State<GSRadioGroupField> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    widget.filteredItems = widget.model.items;
    for (var element in widget.model.items) {
      if (element.isSelected) {
        widget.returnedData = element;
      }
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSRadioGroupField oldWidget) {
    widget.textController = oldWidget.textController;
    widget.filteredItems = oldWidget.filteredItems;
    widget.returnedData = oldWidget.returnedData;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    widget.filteredItems = widget.model.items.where((i) => i.title.contains(widget.keyword) == true).toList();

    for (var element in widget.model.items) {
      if (element.isSelected) {
        widget.returnedData = element;
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.model.searchable
            ? Container(
                margin: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                height: 44,
                decoration: widget.model.searchBoxDecoration ??
                    BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffEAEAEA),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: widget.textController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 8),
                            hintText: widget.model.searchHint,
                            prefixIcon: widget.model.searchIcon ?? const Icon(Icons.search),
                            border: InputBorder.none),
                        onChanged: (text) {
                          widget.keyword = text;
                          widget.filteredItems =
                              widget.model.items.where((i) => i.title.contains(widget.keyword) == true).toList();

                          setState(() {});
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.keyword = '';
                        widget.textController.text = '';
                        widget.filteredItems = widget.model.items;

                        setState(() {});
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.close,
                          color: GSFormColors.hintTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(
                height: 0,
              ),
        SizedBox(
          height: widget.model.height,
          child: RawScrollbar(
            thumbColor: widget.model.scrollBarColor ?? Colors.blue,
            trackRadius: const Radius.circular(6),
            radius: const Radius.circular(6),
            interactive: true,
            controller: controller,
            trackVisibility: true,
            thumbVisibility: true,
            thickness: widget.model.showScrollBar ?? false ? 6 : 0,
            child: ListView.builder(
              scrollDirection: widget.model.scrollDirection ?? Axis.vertical,
              controller: controller,
              itemCount: widget.filteredItems.length,
              shrinkWrap: widget.model.scrollable == null ? false : !widget.model.scrollable!,
              physics: !widget.model.scrollable! ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      for (var element in widget.filteredItems) {
                        element.isSelected = false;
                      }
                      widget.filteredItems[index].isSelected = true;
                      widget.model.callBack(widget.filteredItems[index]);
                      widget.returnedData = widget.filteredItems[index];
                      setState(() => {});
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: RadioItem(widget.filteredItems[index], widget.model, widget.formStyle!),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
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
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
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
                margin: const EdgeInsetsDirectional.only(start: 8.0),
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
