import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/values/theme.dart';
import 'package:gsform/gs_form/widget/field.dart';
import 'package:gsform/gs_form/widget/fields/text_plain_field.dart';

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
              flex: field.model?.weight ?? 12,
              child: field,
            ),
          );

          weightSum += field.model?.weight ?? 12;
          if (i < fields.length - 1 && fields[i + 1] is GSField && fields[i + 1] is! GSTextPlainField) {
            field.model?.nextFocusNode = (fields[i + 1] as GSField).model?.focusNode;
          }
          field.formStyle = style!;
          i++;

          // This is a condition for the interval between the two phases of the first two phases and the desired actions.
          if (weightSum != 12) {
            childrenAtRow.add(const SizedBox(
              width: 12,
            ));
          }
        }
        rows.add(Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: childrenAtRow));
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
            ? Padding(
                padding: const EdgeInsetsDirectional.only(start: 4),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          sectionTitle!,
                          style: style?.sectionTitleStyle ?? GSFormTheme.textThemeStyle.displayLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                  ],
                ),
              )
            : Container(),
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
                left: style!.sectionCardPadding, right: style!.sectionCardPadding, top: style!.sectionCardPadding, bottom: style!.sectionCardPadding),
            child: ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rows.length,
                itemBuilder: (context, index) {
                  return rows[index];
                }),
          ),
        ),
      ],
    );
  }
}
