import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/enums/required_check_list_enum.dart';
import 'package:gsform/gs_form/model/data_model/check_data_model.dart';
import 'package:gsform/gs_form/model/fields_model/checkbox_model.dart';
import 'package:gsform/gs_form/values/colors.dart';

import '../../core/field_callback.dart';

// ignore: must_be_immutable
class GSCheckListField extends StatefulWidget implements GSFieldCallBack {
  final GSCheckBoxModel model;
  final GSFormStyle? formStyle;
  ScrollController controller = ScrollController();
  TextEditingController textController = TextEditingController();
  List<CheckDataModel> filteredItems = [];

  String keyword = "";

  GSCheckListField(this.model, this.formStyle, {Key? key}) : super(key: key);

  List<CheckDataModel> valueObject = [];

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
      if (model.requiredCheckListEnum == RequiredCheckListEnum.atLeastOneItem) {
        return valueObject.isNotEmpty;
      } else {
        return valueObject.length == model.items.length;
      }
    }
  }
}

class _GSCheckListFieldState extends State<GSCheckListField> {
  @override
  void initState() {
    widget.filteredItems = widget.model.items;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GSCheckListField oldWidget) {
    widget.filteredItems = oldWidget.filteredItems;
    widget.valueObject = oldWidget.valueObject;
    widget.textController = oldWidget.textController;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
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
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: widget.textController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 8),
                          hintText: widget.model.searchHint,
                          prefixIcon: widget.model.searchIcon ?? const Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          setState(() {
                            widget.keyword = text;
                            widget.filteredItems =
                                widget.model.items.where((i) => i.title.contains(widget.keyword) == true).toList();
                          });
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
            controller: widget.controller,
            trackVisibility: true,
            thumbVisibility: true,
            thickness: widget.model.showScrollBar ?? false ? 6 : 0,
            child: ListView.builder(
              controller: widget.controller,
              itemCount: widget.filteredItems.length,
              shrinkWrap: widget.model.scrollable == null ? false : !widget.model.scrollable!,
              physics: !widget.model.scrollable! ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      CheckDataModel item = widget.filteredItems[index];
                      item.isSelected = !item.isSelected;
                      if (item.isSelected) {
                        widget.valueObject.add(item);
                      } else {
                        widget.valueObject.removeWhere((element) => element.data == item.data);
                      }
                      widget.model.callBack(item);
                      setState(() {});
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: CheckBoxItem(widget.filteredItems[index], widget.model, widget.formStyle!),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
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
          Expanded(
            child: Text(
              _item.title,
              style: formStyle.fieldTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
