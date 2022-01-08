import 'package:flutter/material.dart';
import 'package:mobailshop/data/model/base/api_response.dart';
import 'package:mobailshop/data/model/base/error_response.dart';

import 'package:mobailshop/data/model/body/registershop_model.dart';
import 'package:mobailshop/provider/database.dart';
import 'package:mobailshop/repository/shop_repo.dart';

class ShopProvider with ChangeNotifier {
  final ShopRepo shopRepo;
  ShopProvider({required this.shopRepo});
  bool _isLoading = false;
  bool _isRemember = false;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool get isRemember => _isRemember;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Future registration(ShopModel register, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await shopRepo.registration(register);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      var map = apiResponse.response.data;
      callback(true, 'map');
      Map<String, dynamic> userInfoMap = {
        "nameShop": map["nameShop"],
        "address": map["address"],
        "logo": map["logo"],
      };

      databaseMethods.addUserInfoToDB(map["_id"], userInfoMap);
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

  // Future login(LoginModel loginBody, Function callback) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   ApiResponse apiResponse = await shopRepo.login(loginBody);

  //   _isLoading = false;

  //   if (apiResponse.response != null &&
  //       apiResponse.response.statusCode == 200) {
  //     Map map = apiResponse.response.data;
  //     String token = map["token"];
  //     callback(true, token);
  //     notifyListeners();
  //   } else {
  //     String errorMessage;
  //     if (apiResponse.error is String) {
  //       print(apiResponse.error.toString());
  //       errorMessage = apiResponse.error.toString();
  //     } else {
  //       ErrorResponse errorResponse = apiResponse.error;
  //       print(errorResponse.success);
  //       errorMessage = errorResponse.error;
  //     }
  //     callback(false, errorMessage);
  //     notifyListeners();
  //   }
  // }

  String getShopName() {
    return shopRepo.getShopName();
  }

  Future<bool> clearUserEmailAndPassword() async {
    return shopRepo.clearUserEmailAndPassword();
  }

  String getUserPassword() {
    return shopRepo.getUserPassword();
  }

  void saveShopNameandAdrssec(String email, String password) {
    shopRepo.saveShopNameandAdrssec(email, password);
  }
}
