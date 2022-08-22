import 'dart:io';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/enums/filed_required_type.dart';
import 'package:gsform/gs_form/model/fields_model/image_picker_model.dart';
import 'package:gsform/gs_form/util/util.dart';
import 'package:gsform/gs_form/values/colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class GSImagePickerField extends StatefulWidget implements GSFieldCallBack {
  final GSImagePickerModel model;
  final GSFormStyle formStyle;

  GSImagePickerField(this.model, this.formStyle, {Key? key}) : super(key: key);
  String? _croppedFilePath;

  @override
  State<GSImagePickerField> createState() => _GSImagePickerFieldState();

  @override
  getValue() {
    return _croppedFilePath!;
  }

  @override
  bool isValid() {
    if (!(model.required ?? false)) {
      return true;
    } else {
      return _croppedFilePath != null;
    }
  }
}

class _GSImagePickerFieldState extends State<GSImagePickerField> {
  @override
  void initState() {
    super.initState();
    widget._croppedFilePath = null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onTap: () {
            if (widget.model.allowPickedFromGallery ?? false) {
              GSFormUtils.showImagePickerBottomSheet(
                cameraName: widget.model.cameraPopupTitle,
                galleryName: widget.model.galleryPopupTitle,
                cameraAssets: widget.model.cameraPopupIcon,
                galleryAssets: widget.model.galleryPopupIcon,

                context,
                (image) async {
                  _fillImagePath(image);
                },
              );
            } else {
              GSFormUtils.pickImage(ImageSource.camera).then(
                (imageFile) {
                  if (imageFile != null) {
                    _fillImagePath(imageFile);
                  }
                },
              );
            }
          },
          child: widget._croppedFilePath == null
              ? NormalView(model: widget.model, formStyle: widget.formStyle)
              : ImagePickedView(
                  croppedFilePath: widget._croppedFilePath!,
                  model: widget.model,
                  formStyle: widget.formStyle,
                  onDeleteImage: () {
                    widget._croppedFilePath = null;
                    setState(() {});
                  }),
        ),
      ),
    );
  }

  _fillImagePath(File image) {
    if (widget.model.showCropper ?? false) {
      _cropImage(image);
    } else {
      setState(() {});
      widget._croppedFilePath = image.path;
    }
  }

  Future<void> _cropImage(File image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'ویرایش تصویر',
            toolbarColor: GSFormColors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        widget._croppedFilePath = croppedFile.path;
      });
    }
  }
}

class NormalView extends StatelessWidget {
  const NormalView({required this.model, required this.formStyle, Key? key}) : super(key: key);
  final GSImagePickerModel model;
  final GSFormStyle formStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            model.iconAsset,
            color: Colors.red,
            height: 30.0,
            width: 30.0,
          ),
          const SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Opacity(
                  opacity: _showRequiredStar(),
                  child: const Text(
                    '*',
                    style: TextStyle(
                      color: GSFormColors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Text(
                model.title ?? '',
                style: formStyle.titleTextStyle,
              ),
              Visibility(
                visible: _showRequiredText() == 1 ? true : false,
                child: Text(
                  formStyle.requiredText,
                  style: const TextStyle(
                    color: GSFormColors.red,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            model.hint ?? '',
            style: formStyle.fieldHintStyle,
          ),
        ],
      ),
    );
  }

  _showRequiredStar() {
    if (model.required != null) {
      if (model.required!) {
        if (formStyle.requireType == GSFieldRequireTypeEnum.star) {
          return 1.0;
        }
      }
    }
    return 0.0;
  }

  _showRequiredText() {
    if (model.required != null) {
      if (model.required!) {
        if (formStyle.requireType == GSFieldRequireTypeEnum.text) {
          return 1.0;
        }
      }
    }

    return 0.0;
  }
}

// ignore: must_be_immutable
class ImagePickedView extends StatelessWidget {
  String croppedFilePath;
  final GSImagePickerModel model;
  final GSFormStyle formStyle;
  final VoidCallback onDeleteImage;

  ImagePickedView(
      {required this.croppedFilePath,
      Key? key,
      required this.model,
      required this.formStyle,
      required this.onDeleteImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(File(croppedFilePath), fit: BoxFit.contain),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 32.0,
              decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: SmoothBorderRadius.only(
                  bottomLeft: SmoothRadius(
                    cornerRadius: 11.0,
                    cornerSmoothing: 1,
                  ),
                  bottomRight: SmoothRadius(
                    cornerRadius: 11.0,
                    cornerSmoothing: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Row(
                  children: [
                    Text(
                      model.title!,
                      style: formStyle.titleTextStyle.copyWith(color: Colors.white),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 20.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          onDeleteImage.call();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 8),
                            Text(
                              'حذف',
                              maxLines: 1,
                              style: formStyle.titleTextStyle.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
