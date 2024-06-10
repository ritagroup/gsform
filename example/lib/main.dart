import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/enums/field_status.dart';
import 'package:gsform/gs_form/model/data_model/date_data_model.dart';
import 'package:gsform/gs_form/model/data_model/radio_data_model.dart';
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
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      locale: const Locale('en', 'US'),
      supportedLocales: const [Locale('en', 'US'), Locale('fa', 'IR')],
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        textTheme: null,
        colorScheme: null,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark, colorScheme: null),
      home: SingleSectionForm(),
    );
  }
}

// ignore: must_be_immutable

// ignore: must_be_immutable
class SingleSectionForm extends StatefulWidget {
  SingleSectionForm({Key? key}) : super(key: key);
  String? value;

  late GSFieldStatusEnum status;

  @override
  State<SingleSectionForm> createState() => _SingleSectionFormState();
}

class _SingleSectionFormState extends State<SingleSectionForm> {
  late GSForm form;
  int id = 0;

  @override
  void initState() {
    widget.value = 'dfhbdkfhbdasffffteryuiei577y ';
    widget.status = GSFieldStatusEnum.normal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Single section Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: form = GSForm.singleSection(
                      style: GSFormStyle(
                        sectionCardElevation: 0,
                        backgroundSectionColor: Colors.white,
                        fieldBorderColor: Colors.grey,
                        backgroundFieldColor: Colors.white,
                        titleStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                        ),
                      ),
                      context,
                      fields: [
                        GSField.text(
                          tag: 'email',
                          title: 'text',
                          required: false,
                          maxLength: 100,
                          hint: 'text',
                          errorMessage: 'error',
                        ),
                        GSField.email(
                          tag: 'email',
                          title: 'email',
                          weight: 12,
                          required: true,
                          showTitle: false,
                          maxLength: 100,
                          hint: 'dastras.saeed@gmail.com',
                          validateRegEx:RegExp(r'^.{5,10}$') ,
                          errorMessage: 'error',
                        ),
                        GSField.password(
                          tag: 'email',
                          title: 'password',
                          showTitle: false,
                          weight: 12,
                          required: true,
                          maxLength: 100,
                          hint: '123456',
                          errorMessage: 'error',
                        ),

                        GSField.mobile(
                          tag: 'email',
                          title: 'login',
                          weight: 12,
                          required: true,
                          showTitle: false,
                          maxLength: 100,
                          value: 'dastras.saeed@gmail.com',
                          errorMessage: 'error',
                        ),
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
                        debugPrint(map.toString());
                        debugPrint(isValid.toString());
                        setState(() {});
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
