import 'package:flutter/material.dart';

import 'field_model.dart';

class GSImagePickerModel extends GSFieldModel {
  String? hint;
  Widget iconWidget;
  String? cameraPopupTitle;
  String? galleryPopupTitle;
  String? cameraPopupIcon;
  String? galleryPopupIcon;
  GSImageSource? imageSource;
  bool? showCropper;
  double? maximumSizePerImageInBytes;
  VoidCallback? onErrorSizeItem;

  GSImagePickerModel({
    type,
    tag,
    title,
    errorMessage,
    helpMessage,
    required,
    status,
    weight,
    showTitle,
    value,
    required this.iconWidget,
    this.cameraPopupIcon,
    this.galleryPopupIcon,
    this.showCropper,
    this.cameraPopupTitle,
    this.galleryPopupTitle,
    this.imageSource,
    this.hint,
    this.maximumSizePerImageInBytes,
    this.onErrorSizeItem,
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
            value: value);
}

enum GSImageSource { camera, gallery, both }
