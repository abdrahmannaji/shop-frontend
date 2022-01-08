import 'package:dio/dio.dart';

import 'package:mobailshop/data/model/base/api_error_handler.dart';
import 'package:mobailshop/data/model/base/api_response.dart';

import 'package:mobailshop/data/model/body/registershop_model.dart';

import 'package:mobailshop/utill/app_constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

Dio dio = Dio();

class ShopRepo {
  // DioClient dioClient;
  SharedPreferences sharedPreferences;
  ShopRepo({
    required this.sharedPreferences,
  });
  late String? token = sharedPreferences.getString(AppConstants.TOKEN)!;
  late String getUserToken =
      sharedPreferences.getString(AppConstants.TOKEN) ?? "";

  Future<ApiResponse> registration(ShopModel register) async {
    print("token:$getUserToken");
    try {
      Response response = await dio.post(
          "${AppConstants.BASE_URL}api/v1/shops/register",
          data: register.toJson(),
          options: Options(headers: {'Authorization': 'Bearer $getUserToken'}));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // Future<ApiResponse> login(LoginModel loginBody) async {
  //   try {
  //     Response response = await Dio().post(
  //       '${AppConstants.BASE_URL}api/v1/shop/login',
  //       data: loginBody.toJson(),
  //       options: Options(headers: {"Content-Type": "application/json"}),
  //     );
  //     print('object');
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     print('object:$e');
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

  // for  Remember Email

  Future<void> saveShopNameandAdrssec(String name, String asrssec) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, asrssec);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, name);
    } catch (e) {
      throw e;
    }
  }

  String getShopName() {
    return sharedPreferences.getString(AppConstants.SHOP_NAME) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.SHOP_ADDRESS) ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    await sharedPreferences.remove(AppConstants.SHOP_ADDRESS);
    return await sharedPreferences.remove(AppConstants.SHOP_NAME);
  }
}
