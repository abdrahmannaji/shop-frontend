import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobailshop/UI/addproduct/addproduct_screen.dart';
import 'package:mobailshop/data/model/base/api_response.dart';
import 'package:mobailshop/data/model/base/error_response.dart';
import 'package:mobailshop/data/model/body/addproduct_modil.dart';
import 'package:mobailshop/repository/addproduc_repo.dart';

class AddproductProvider with ChangeNotifier {
  late AddproductRepot addproductRepot;
  AddproductProvider({required this.addproductRepot});

  Future addproduct(AddproductModile addproductModile, Function callback,
      File getimage, _color) async {
    // _isLoading = true;
    // notifyListeners();
    ApiResponse apiResponse =
        await addproductRepot.add(addproductModile, getimage, _color);
    // _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      callback(true, 'map');
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.success);
        errorMessage = errorResponse.error;
      }
      callback(false, errorMessage);
      notifyListeners();
    }
  }
}
