import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/enums/filed_required_type.dart';
import 'package:gsform/gs_form/model/data_model/date_data_model.dart';
import 'package:gsform/gs_form/model/data_model/spinner_data_model.dart';
import 'package:gsform/gs_form/widget/field.dart';
import 'package:gsform/gs_form/widget/form.dart';
import 'package:gsform/gs_form/widget/section.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainTestPage(),
    );
  }
}

class MainTestPage extends StatelessWidget {
  MainTestPage({Key? key}) : super(key: key);

  late GSForm form;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFf6f6f6),
        appBar: AppBar(
          title: const Text('GSForm example'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(builder: (BuildContext context) => MultiSectionForm()),
                          (route) => true, //if you want to disable back feature set to false
                    );
                  },
                  child: const Text('Multi Section form'),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(builder: (BuildContext context) => SingleSectionForm()),
                          (route) => true, //if you want to disable back feature set to false
                    );
                  },
                  child: const Text('Single Section form'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
                          maxLength: 150,
                          showCounter: true,
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

class SingleSectionForm extends StatelessWidget {
  SingleSectionForm({Key? key}) : super(key: key);

  late GSForm form ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf6f6f6),
      appBar: AppBar(
        title: const Text('Single section Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: form = GSForm.singleSection(
                    style: GSFormStyle(
                      backgroundFieldColor: const Color(0xfff5f5f5),
                      backgroundSectionColor: const Color(0xffffffff),
                      sectionCardElevation: 0,
                      titleStyle:
                      const TextStyle(color: Color(0xff999999), fontWeight: FontWeight.w500, fontSize: 12.0),
                      fieldHintStyle:
                      const TextStyle(color: Color(0xff999999), fontWeight: FontWeight.w500, fontSize: 10.0),
                      fieldTextStyle:
                      const TextStyle(color: Color(0xff262626), fontWeight: FontWeight.w500, fontSize: 12.0),
                      sectionRadius: 10.0,
                      requireType: GSFieldRequireTypeEnum.star,
                    ),
                    context,
                    fields: [
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
                      GSField.spinner(
                        hint: 'Spinner',
                        tag: 'customer_type',
                        required: false,
                        weight: 12,
                        title: 'Customer Type',
                        items: [
                          SpinnerDataModel(
                            name: 'value1',
                            id: 1,
                          ),
                          SpinnerDataModel(
                            name: 'value2',
                            id: 2,
                          ),
                        ],
                      ),
                      GSField.text(
                        tag: 'name',
                        title: 'Name',
                        minLine: 1,
                        maxLine: 1,
                        weight: 6,
                        required: false,
                        errorMessage: 'please enter a name',
                      ),
                      GSField.text(
                        tag: 'lastName',
                        title: 'Last name',
                        minLine: 1,
                        maxLine: 1,
                        weight: 6,
                        required: true,
                      ),
                      GSField.number(
                        tag: 'code',
                        title: 'Code',
                        maxLength: 10,
                        weight: 12,
                        required: true,
                        errorMessage: 'some error',
                        hint: 'code',
                      ),
                      GSField.mobile(
                        tag: 'mobile',
                        title: 'Phone number',
                        maxLength: 11,
                        helpMessage: 'some help',
                        weight: 12,
                        required: false,
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
                        required: true,
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
                        required: false,
                      ),
                      GSField.price(
                        tag: 'price',
                        title: 'Price',
                        errorMessage: 'error',
                        helpMessage: 'help',
                        currencyName: '\$',
                        weight: 12,
                        required: true,
                      ),
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
                    ],
                  ),
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
      ),
    );
  }
}
