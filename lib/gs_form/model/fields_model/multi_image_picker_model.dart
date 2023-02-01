import 'package:flutter/material.dart';
import 'package:gsform/gs_form/model/fields_model/image_picker_model.dart';

import 'field_model.dart';

class GSMultiImagePickerModel extends GSFieldModel {
  String? hint;
  Widget iconWidget;
  String? cameraPopupTitle;
  String? galleryPopupTitle;
  String? cameraPopupIcon;
  String? galleryPopupIcon;
  GSImageSource? imageSource;
  bool? showCropper;
  List<String>? defaultImagePath;
  double? maximumSizePerImageInKB;
  double? maximumImageCount;
  VoidCallback? onErrorSizeItem;

  GSMultiImagePickerModel({
    type,
    tag,
    title,
    errorMessage,
    helpMessage,
    required,
    status,
    weight,
    showTitle,
    required this.iconWidget,
    this.maximumImageCount,
    this.onErrorSizeItem,
    this.maximumSizePerImageInKB,
    this.defaultImagePath,
    this.cameraPopupIcon,
    this.galleryPopupIcon,
    this.showCropper,
    this.cameraPopupTitle,
    this.galleryPopupTitle,
    this.imageSource,
    this.hint,
  }) : super(
          type: type,
          tag: tag,
          title: title,
          errorMessage: errorMessage,
          helpMessage: helpMessage,
          required: required,
          status: status,
          weight: weight,
          showTitle: showTitle,
        );
}
