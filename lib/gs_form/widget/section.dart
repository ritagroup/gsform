import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/values/theme.dart';
import 'package:gsform/gs_form/widget/field.dart';

// ignore: must_be_immutable
class GSSection extends StatelessWidget {
  late List<Widget> fields;
  GSFormStyle? style;
  String? sectionTitle;

  GSSection({Key? key, required this.fields, this.style, required this.sectionTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    style = style ?? GSFormStyle();

    List<Row> rows = [];

    int i = 0; // while index on fields
    int weightSum = 0;

    while (i < fields.length) {
      if (fields[i] is GSField) {
        List<Widget> childrenAtRow = []; // children in each row
        while (weightSum < 12 && i <= fields.length - 1) {
          GSField field = fields[i] as GSField;
          childrenAtRow.add(
            Expanded(
              flex: field.model.weight ?? 12,
              child: field,
            ),
          );
          weightSum += field.model.weight ?? 12;
          if (i < fields.length - 1 && fields[i + 1] is GSField) {
            field.model.nextFocusNode = (fields[i + 1] as GSField).model.focusNode;
          }
          field.formStyle = style!;
          i++;
        }
        rows.add(Row(children: childrenAtRow));
        weightSum = 0;
      } else {
        rows.add(
          Row(
            children: [
              Expanded(
                flex: 12,
                child: fields[i],
              )
            ],
          ),
        );
        i++;
      }
    }

    return Column(
      children: [
        sectionTitle != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                    child: Text(
                      sectionTitle!,
                      style: GSFormTheme.textThemeStyle.headline1,
                    ),
                  ),
                ],
              )
            : Container(),
        const SizedBox(height: 6.0),
        Card(
          color: style?.backgroundSectionColor,
          elevation: style?.sectionCardElevation,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: style!.sectionRadius,
              cornerSmoothing: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: style!.sectionCardPadding, right: style!.sectionCardPadding, top: 12.0, bottom: 8.0),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rows.length,
                itemBuilder: (context, index) {
                  return rows[index];
                }),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
