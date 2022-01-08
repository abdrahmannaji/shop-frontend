import 'package:dio/dio.dart';
import 'package:mobailshop/data/model/base/api_error_handler.dart';
import 'package:mobailshop/data/model/base/api_response.dart';
import 'package:mobailshop/main.dart';
import 'package:mobailshop/repository/auth_repo.dart';
import 'package:mobailshop/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class Getshop_Repot {
  final SharedPreferences sharedPreferences;
  Getshop_Repot({
    required this.sharedPreferences,
  });

  Future<ApiResponse> getShop() async {
    try {
      print("ddc$getUserToken");
      Response response =
          await dio.get("${AppConstants.BASE_URL}api/v1/shops/getShop",
              options: Options(
                headers: {'Authorization': 'Bearer $getUserToken'},
              ));

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<void> saveShopname(String token) async {
    // ignore: unused_local_variable
    String tokens = sharedPreferences.getString(AppConstants.SHOP_NAME) ?? "";

    tokens = token;
    dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    try {
      await sharedPreferences.setString(AppConstants.SHOP_NAME, token);
    } catch (e) {
      throw e;
    }
  }

  String getShopname() {
    return sharedPreferences.getString(AppConstants.SHOP_NAME) ?? "";
  }

  String getShopid() {
    return sharedPreferences.getString(AppConstants.ShopId) ?? "";
  }

  Future<void> saveShopid(String token) async {
    String tokens = sharedPreferences.getString(AppConstants.ShopId) ?? "";

    tokens = token;
    dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences.setString(AppConstants.ShopId, token);
    } catch (e) {
      throw e;
    }
  }
}
