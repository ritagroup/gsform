import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/enums/filed_required_type.dart';
import 'package:gsform/gs_form/model/data_model/date_data_model.dart';
import 'package:gsform/gs_form/widget/field.dart';
import 'package:gsform/gs_form/widget/form.dart';
import 'package:gsform/gs_form/widget/section.dart';

class MultiSectionForm extends StatelessWidget {
   MultiSectionForm({Key? key}) : super(key: key);

  late GSForm form ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf6f6f6),
      appBar: AppBar(
        title: const Text('Multi section screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: form =GSForm.multiSection(context,
                    style: GSFormStyle(
                      backgroundFieldColor: const Color(0xfff5f5f5),
                      backgroundSectionColor: const Color(0xffffffff),
                      sectionCardElevation: 0,
                      titleStyle: const TextStyle(color: Color(0xff999999), fontWeight: FontWeight.w500, fontSize: 12.0),
                      fieldHintStyle: const TextStyle(color: Color(0xff999999), fontWeight: FontWeight.w500, fontSize: 10.0),
                      fieldTextStyle: const TextStyle(color: Color(0xff262626), fontWeight: FontWeight.w500, fontSize: 12.0),
                      sectionRadius: 10.0,
                      requireType: GSFieldRequireTypeEnum.text,
                      requiredText:'required'
                    ),
                    sections: [
                      GSSection(fields: [
                        GSField.mobile(
                          tag: 'mobile',
                          title: 'Phone number',
                          maxLength: 11,
                          helpMessage: 'some help',
                          weight: 12,
                          errorMessage: 'some error',
                          hint: 'some hint',
                        ),
                        GSField.textPlain(
                          tag: 'explain',
                          title: 'Explain',
                          weight: 12,
                          required: true,
                        ),
                        GSField.password(
                          tag: 'password',
                          title: 'Password',
                          errorMessage: 'error',
                          weight: 12,
                          helpMessage: 'help',
                        ),
                        GSField.email(
                          tag: 'email',
                          title: 'Email',
                          errorMessage: 'error',
                          helpMessage: 'help',
                          postfixWidget: const Icon(Icons.email),
                          weight: 12,
                          prefixWidget: const Icon(Icons.verified_user),
                          required: true,
                        ),
                      ], sectionTitle: 'section 1'),
                      GSSection(fields: [
                        GSField.datePicker(
                          tag: 'licenceExpireDate',
                          title: 'DatePicker',
                          weight: 12,
                          required: true,
                          postfixWidget: const Icon(Icons.calendar_month),
                          displayDateType: GSDateFormatType.numeric,
                          initialDate: GSDate(
                            day: DateTime.now().day,
                            month: DateTime.now().month,
                            year: DateTime.now().year,
                          ),
                          calendarType: GSCalendarType.gregorian,
                        ),
                        GSField.dateRangePicker(
                          tag: 'licenceExpireDate',
                          title: 'DatePicker',
                          weight: 12,
                          from: 'from',
                          to: 'to',
                          required: true,
                          postfixWidget: const Icon(Icons.calendar_month),
                          displayDateType: GSDateFormatType.numeric,
                          initialDate: GSDate(
                            day: DateTime.now().day,
                            month: DateTime.now().month,
                            year: DateTime.now().year,
                          ),
                          calendarType: GSCalendarType.gregorian,
                        ),
                        GSField.time(
                          tag: 'licenceExpireDate',
                          title: 'TimePicker',
                          hint: 'pick time',
                          weight: 12,
                          required: false,
                          postfixWidget: const Icon(Icons.punch_clock_sharp),
                        ),
                      ], sectionTitle: 'section 1'),
                      GSSection(fields: [
                        GSField.imagePicker(
                          tag: 'img',
                          iconAssets: 'assets/icons/ic_picture.svg',
                          title: 'ImagePicker',
                          errorMessage: 'some error',
                          helpMessage: 'some help',
                          hint: 'Take or choose a photo',
                          required: true,
                          weight: 12,
                          iconColor: Colors.red,
                        ),
                        GSField.qrScanner(
                          tag: 'qr',
                          iconAssets: 'assets/icons/ic_qr_code.svg',
                          title: 'Barcode',
                          hint: "Scan Some Barcodes",
                          required: true,
                          weight: 12,
                          iconColor: Colors.grey,
                          helpMessage: 'some help',
                          showTitle: false,
                          errorMessage: 'error',
                        ),
                      ], sectionTitle: 'section 1'),
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      bool isValid = form.isValid();
                      Map<String, dynamic> map = form.onSubmit();
                      debugPrint(isValid.toString());
                      debugPrint(map.toString());
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
