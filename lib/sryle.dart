import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mobailshop/mainaccont.dart';
import 'package:mobailshop/utill/color_resources.dart';

dialogerror(BuildContext context, datamasg) {
  return AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          headerAnimationLoop: false,
          title: 'خطاء',
          desc: datamasg,
          btnOkOnPress: () {},
          btnOkColor: ColorResources.pink787)
      .show();
}

final picker = ImagePicker();

getImage(image1) async {
  PickedFile? pickedFile = await picker.getImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    print(pickedFile.path);
    image1 = pickedFile.path;
    image1 = pickedFile.path;

    imageget = File(image1);

    print(json.encode(image1));
    print("file path...");
    return imageget;
  } else {
    print('No image selected.');
  }
}

decorationfunc(color) {
  return BoxDecoration(
    color: color,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(22),
    boxShadow: [
      BoxShadow(
        color: ColorResources.pink0373,
        blurRadius: 10.0,
      ),
    ],
  );
}

var textStyle =
    TextStyle(fontSize: ScreenUtil().setSp(20.0), color: Colors.black);
var textStyle1 =
    TextStyle(fontSize: ScreenUtil().setSp(16.0), color: Colors.black);
var sizedbox = SizedBox(
  height: ScreenUtil().setHeight(10),
);

InputDecoration buildInputDecoration_1({hint_text = ""}) {
  return InputDecoration(
      hintText: hint_text,
      hintStyle: TextStyle(
        fontSize: 12.0,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 0.5),
        borderRadius: const BorderRadius.all(
          const Radius.circular(5.0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.0),
        borderRadius: const BorderRadius.all(
          const Radius.circular(5.0),
        ),
      ),
      contentPadding: EdgeInsets.only(left: 16.0));
}
