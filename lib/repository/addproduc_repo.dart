import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobailshop/UI/widget/viewImage.dart';

import 'package:mobailshop/data/model/base/api_error_handler.dart';
import 'package:mobailshop/data/model/base/api_response.dart';
import 'package:mobailshop/data/model/body/addproduct_modil.dart';

import 'package:mobailshop/main.dart';
import 'package:mobailshop/UI/addproduct/addproduct_screen.dart';
import 'package:mobailshop/repository/auth_repo.dart';
import 'package:mobailshop/utill/app_constants.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddproductRepot {
  final SharedPreferences sharedPreferences;
  AddproductRepot({
    required this.sharedPreferences,
  });

  Future<ApiResponse> add(
      AddproductModile addproductModile, File getimage, Color _color) async {
    // ignore: deprecated_member_use

    List<MultipartFile> multipartImageList = <MultipartFile>[];

    for (Asset asset in image) {
      ByteData byteData = await asset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = MultipartFile.fromBytes(
        imageData,
        filename: 'some-file-name.jpg',
        contentType: MediaType("image", "jpg"),
      );
      multipartImageList.add(multipartFile);
    }
    print("asd$shopid");
    String failname = getimage.path.split('/').last;
    try {
      Response response =
          await dio.post("${AppConstants.BASE_URL}api/v1/product",
              data: FormData.fromMap({
                // addproductModile.toJson(),
                "name": addproductModile.name,
                "shop_id": shopid,
                "dscount": addproductModile.dscount,
                "tax": addproductModile.tax,
                "description": addproductModile.description,
                "type_phone": addproductModile.typePhone,
                "phone_size": addproductModile.phoneSize,
                "phone_Weight": addproductModile.phoneWeight,
                "battery_capacity": addproductModile.batteryCapacity,
                "Phone_version": addproductModile.phoneVersion,
                "colors": addproductModile.colors,
                "status": addproductModile.status,
                "rem": addproductModile.rem,
                "rom": addproductModile.rom,
                "unit_price": addproductModile.unitPrice,
                "quantity": addproductModile.quantity,
                "purchase_price": addproductModile.purchasePrice,
                "colorimg": _color,
                "images": multipartImageList,
                "avatar": await MultipartFile.fromFile(
                  getimage.path,
                  filename: failname,
                  contentType: MediaType("image", "jpg"),
                ),
              }),
              options: Options(
                headers: {'Authorization': 'Bearer $getUserToken'},
              ));
      print('sjdg');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      // getim();
      // print(getim());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // Future<File> getImageFileFromAsset(var path) async {
  //   final file = File(path);
  //   return file;
  // }

  // getim() async {
  //   for (int i = 0; i < image.length; i++)
  //     await getImageFileFromAsset(image[i].identifier);
  // }
}
