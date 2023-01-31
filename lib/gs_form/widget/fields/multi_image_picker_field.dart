import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/field_callback.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/fields_model/image_picker_model.dart';
import 'package:gsform/gs_form/util/util.dart';
import 'package:gsform/gs_form/values/colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/fields_model/multi_image_picker_model.dart';

// ignore: must_be_immutable
class GSMultiImagePickerField extends StatefulWidget implements GSFieldCallBack {
  final GSMultiImagePickerModel model;
  final GSFormStyle formStyle;

  GSMultiImagePickerField(this.model, this.formStyle, {Key? key}) : super(key: key);
  List<String>? _croppedFilePaths = [];

  @override
  State<GSMultiImagePickerField> createState() => _GSMultiImagePickerFieldState();

  @override
  getValue() {
    return _croppedFilePaths;
  }

  @override
  bool isValid() {
    if (!(model.required ?? false)) {
      return true;
    } else {
      return (_croppedFilePaths ?? []).isNotEmpty;
    }
  }
}

class _GSMultiImagePickerFieldState extends State<GSMultiImagePickerField> {
  @override
  void initState() {
    super.initState();
    if ((widget.model.defaultImagePath ?? []).isNotEmpty) {
      widget._croppedFilePaths = widget.model.defaultValue;
    } else {
      widget._croppedFilePaths = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: widget._croppedFilePaths!.length + 1,
          itemBuilder: (context, index) {
            return index == 0
                ? SelectItem(
                    model: widget.model,
                    style: widget.formStyle,
                    isEnable: _enableSelectImageButton(),
                    callBack: (imagePath) {
                      widget._croppedFilePaths?.add(imagePath);
                      setState(() {});
                    },
                  )
                : ImageBox(imagePath: widget._croppedFilePaths?[index - 1] ?? '');
          }),
    );
  }

  bool _enableSelectImageButton(){
    if(widget.model.maximumImageCount!=null) {
      if (widget._croppedFilePaths!.length  >= widget.model.maximumImageCount!){
        return false ;
      }else {
        return true ;
      }
    }else {
      return true ;
    }
  }
}

class SelectItem extends StatelessWidget {
  const SelectItem({required this.model, required this.style, required this.callBack, required this.isEnable, Key? key})
      : super(key: key);

  final GSMultiImagePickerModel model;
  final GSFormStyle style;
  final ValueChanged<String> callBack;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AbsorbPointer(
        absorbing: !isEnable,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: Colors.black45, width: 1)),
          height: 90,
          width: 90,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onTap: () {
              if (model.imageSource == GSImageSource.both) {
                GSFormUtils.showImagePickerBottomSheet(
                  cameraName: model.cameraPopupTitle,
                  galleryName: model.galleryPopupTitle,
                  cameraAssets: model.cameraPopupIcon,
                  galleryAssets: model.galleryPopupIcon,
                  context,
                  (image) async {
                    _fillImagePath(image);
                  },
                );
              } else if (model.imageSource == GSImageSource.camera) {
                GSFormUtils.pickImage(ImageSource.camera).then(
                  (imageFile) {
                    if (imageFile != null) {
                      _fillImagePath(imageFile);
                    }
                  },
                );
              } else {
                GSFormUtils.pickImage(ImageSource.gallery).then(
                  (imageFile) {
                    if (imageFile != null) {
                      _fillImagePath(imageFile);
                    }
                  },
                );
              }
            },
            child: Container(
              color: isEnable ? Colors.transparent : Colors.black45,
              child: model.iconWidget,
            ),
          ),
        ),
      ),
    );
  }

  _fillImagePath(File image) {
    if (model.showCropper ?? false) {
      _cropImage(image);
    } else {
      if (model.maximumSizePerImageInBytes != null) {
        if (image.lengthSync() > model.maximumSizePerImageInBytes!) {
          callBack.call(image.path);
        } else {
          model.onErrorSizeItem?.call();
        }
      } else {
        callBack.call(image.path);
      }
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
      if (model.maximumSizePerImageInBytes != null) {
        if (image.lengthSync() > model.maximumSizePerImageInBytes!) {
          model.onErrorSizeItem?.call();
        } else {
          callBack.call(image.path);
        }
      } else {
        callBack.call(image.path);
      }
    }
  }


}

class ImageBox extends StatelessWidget {
  const ImageBox({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
      clipBehavior: Clip.hardEdge,
      child: imagePath.contains('http')
          ? Image.network(
              imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.fill,
            )
          : Image.file(
              File(imagePath),
              width: 90,
              height: 90,
              fit: BoxFit.fill,
            ),
    );
  }
}
