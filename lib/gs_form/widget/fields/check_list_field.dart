import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/data_model/check_data_model.dart';
import 'package:gsform/gs_form/model/data_model/radio_data_model.dart';
import 'package:gsform/gs_form/model/fields_model/checkbox_model.dart';
import 'package:gsform/gs_form/model/fields_model/radio_model.dart';

import '../../core/field_callback.dart';

// ignore: must_be_immutable
class GSCheckListField extends StatefulWidget implements GSFieldCallBack {
  final GSCheckBoxModel model;
  final GSFormStyle? formStyle;

  GSCheckListField(this.model, this.formStyle, {Key? key}) : super(key: key);

  List<CheckDataModel> valueObject = [];
  List<int> selectedItems = [];

  @override
  State<GSCheckListField> createState() => _GSCheckListFieldState();

  @override
  getValue() {
    return valueObject;
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

class _GSCheckListFieldState extends State<GSCheckListField> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  String keyword = "";

  @override
  Widget build(BuildContext context) {
    int i = 0;
    widget.valueObject = [];
    for (var element in widget.model.items) {
      if (element.isSelected) {
        widget.selectedItems.add(i);
        widget.valueObject.add(element);
      }
      i++;
    }

    List<CheckDataModel> filteredItems = widget.model.items.where((i) => i.title.contains(keyword) == true).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.model.searchable
            ? Container(
                margin: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                height: 44.0,
                decoration: widget.model.searchBoxDecoration ??
                    BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffEAEAEA),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 8),
                    hintText: widget.model.searchHint,
                    prefixIcon: widget.model.searchIcon ?? const Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                  onChanged: (text) {
                    setState(() {
                      keyword = text;
                    });
                  },
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
              controller: controller,
              itemCount: filteredItems.length,
              shrinkWrap: widget.model.scrollable == null ? false : !widget.model.scrollable!,
              physics: !widget.model.scrollable! ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      filteredItems[index].isSelected = !filteredItems[index].isSelected;

                      widget.model.callBack(filteredItems[index]);
                      setState(() => {});
                      setState(() {});
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: CheckBoxItem(filteredItems[index], widget.model, widget.formStyle!),
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

class CheckBoxItem extends StatelessWidget {
  final CheckDataModel _item;
  final GSFormStyle formStyle;
  final GSCheckBoxModel _model;

  const CheckBoxItem(this._item, this._model, this.formStyle, {Key? key}) : super(key: key);

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
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        )
                      : _model.unSelectedIcon!,
                  Visibility(
                    visible: _item.isSelected,
                    child: _model.selectedIcon == null
                        ? Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(3),
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
