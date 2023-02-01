import 'dart:io';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../core/form_style.dart';
import '../enums/field_status.dart';
import '../values/colors.dart';

class GSFormUtils {
  static bool checkIfDarkModeEnabled(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.brightness == Brightness.dark;
  }

  static Decoration getFieldDecoration(GSFormStyle style, GSFieldStatusEnum? status, {double? borderWidth = 1.0}) {
    Color backgroundColor;
    Color borderColor;

    switch (status) {
      case GSFieldStatusEnum.error:
        backgroundColor = GSFormColors.redOpacity;
        borderColor = GSFormColors.red;
        break;
      case GSFieldStatusEnum.success:
        backgroundColor = GSFormColors.greenOpacity;
        borderColor = GSFormColors.green;
        break;
      case GSFieldStatusEnum.normal:
        backgroundColor = style.backgroundFieldColor;
        borderColor = style.fieldBorderColor;
        break;
      case GSFieldStatusEnum.disabled:
        backgroundColor = style.backgroundFieldColorDisable;
        borderColor = style.fieldBorderColor;
        break;
      default:
        backgroundColor = GSFormColors.white;
        borderColor = GSFormColors.white;
    }
    return ShapeDecoration(
      color: backgroundColor,
      shape: SmoothRectangleBorder(
        side: BorderSide(color: borderColor, width: borderWidth ?? 1.0),
        borderRadius: SmoothBorderRadius(
          cornerRadius: style.fieldRadius,
          cornerSmoothing: 1,
        ),
      ),
    );
  }

  static showImagePickerBottomSheet(
    BuildContext context,
    void Function(File image) callback, {
    String? galleryName = 'Gallery',
    String? cameraName = 'Camera',
    String? cameraAssets,
    String? galleryAssets,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          alignment: Alignment.bottomCenter,
          child: Wrap(
            children: [
              SizedBox(
                height: 130.0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            pickImage(ImageSource.camera).then((imageFile) {
                              if (imageFile != null) {
                                callback(imageFile);
                              }
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              cameraAssets == null
                                  ? const Icon(
                                      Icons.camera,
                                      size: 40.0,
                                      color: Colors.blue,
                                    )
                                  : SvgPicture.asset(
                                      cameraAssets,
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                              const SizedBox(height: 10.0),
                              Text(
                                cameraName ?? 'Camera',
                                style: GSFormStyle().titleTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            pickImage(ImageSource.gallery).then((imageFile) {
                              if (imageFile != null) {
                                callback(imageFile);
                              }
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              galleryAssets == null
                                  ? const Icon(
                                      Icons.photo_library,
                                      size: 40.0,
                                      color: Colors.blue,
                                    )
                                  : SvgPicture.asset(
                                      galleryAssets,
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                              const SizedBox(height: 10.0),
                              Text(
                                galleryName ?? 'Gallery',
                                style: GSFormStyle().titleTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  static Future<File?> pickImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: imageSource,
      maxWidth: 400,
      maxHeight: 400,
    );

    if (image != null) {
      return File(image.path);
    }

    return null;
  }

  static bool isDirectionRTL(BuildContext context){
    return Bidi.isRtlLanguage( Localizations.localeOf(context).languageCode);
  }
}

class CardNumberFormatter extends TextInputFormatter {
  final sampleNumber = '0000 0000 0000 0000';

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > oldValue.text.length) {
      if (newValue.text.length > sampleNumber.length) {
        return oldValue;
      }

      final lastEnteredLetter = newValue.text.substring(newValue.text.length - 1);
      if (!RegExp(r'[0-9]').hasMatch(lastEnteredLetter)) {
        return oldValue;
      }

      if (newValue.text.isNotEmpty && sampleNumber[newValue.text.length - 1] == ' ') {
        return TextEditingValue(
          text: '${oldValue.text} ${newValue.text.substring(newValue.text.length - 1)}',
          selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
        );
      }
    }
    return newValue;
  }
}
