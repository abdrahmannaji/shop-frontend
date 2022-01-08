import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobailshop/data/model/base/api_error_handler.dart';

import 'package:mobailshop/data/model/base/api_response.dart';
import 'package:mobailshop/data/model/body/login_model.dart';
import 'package:mobailshop/data/model/body/otpmodeil.dart';
import 'package:mobailshop/data/model/body/register_model.dart';
import 'package:mobailshop/utill/app_constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

Dio dio = Dio();

class AuthRepo {
  // late DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.sharedPreferences});

  Future<ApiResponse> registration(RegisterModel register) async {
    try {
      Response response = await Dio().post(
        "${AppConstants.BASE_URL}api/v1/auth/register",
        data: register.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login(LoginModel loginBody) async {
    try {
      Response response = await Dio().post(
        '${AppConstants.BASE_URL}api/v1/auth/login',
        data: loginBody.toJson(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      print('object');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('object:$e');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verificationCode(OtpModel otpModel) async {
    try {
      Response response = await Dio().post(
        '${AppConstants.BASE_URL}api/v1/auth/verificationcode',
        data: otpModel.toJson(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );
      print('object');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('object:$e');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

// ApiErrorHandler.getMessage(e, this.sharedPreferences);
  // Future<ApiResponse> updateToken() async {
  //   try {
  //     String _deviceToken = await _getDeviceToken();
  //     FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
  //     Response response = await dio.post(
  //       AppConstants.TOKEN_URI,
  //       data: {"_method": "put", "cm_firebase_token": _deviceToken},
  //     );
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError('sdkj');
  //   }
  // }

  // Future<String> _getDeviceToken() async {
  //   String _deviceToken = (await FirebaseMessaging.instance.getToken())!;
  //   if (_deviceToken != null) {
  //     print('--------Device Token---------- ' + _deviceToken);
  //   }
  //   return _deviceToken;
  // }

  Future<void> saveUserType(String token) async {
    String? tokens = sharedPreferences.getString(AppConstants.UserType);
    print("$tokens");
    tokens = token;
    dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences.setString(AppConstants.UserType, token);
    } catch (e) {
      throw e;
    }
  }

  String getUserid() {
    return sharedPreferences.getString(AppConstants.UserId) ?? "";
  }

  Future<void> saveUserid(String tokenv) async {
    String? token = sharedPreferences.getString(AppConstants.UserId) ?? "";

    token = tokenv;

    try {
      await sharedPreferences.setString(AppConstants.UserId, token);
    } catch (e) {
      throw e;
    }
  }

  String getUserType() {
    return sharedPreferences.getString(AppConstants.UserType) ?? "";
  }

  bool isUserType() {
    return sharedPreferences.containsKey(AppConstants.UserType);
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    String tokens = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
    print("NNNN $tokens");
    tokens = token;
    dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CURRENCY);
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.USER);
    // FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
    return true;
  }

  // for  Remember Email
  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
    } catch (e) {
      throw e;
    }
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.USER_EMAIL) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_EMAIL);
  }

  Future<ApiResponse> forgetPassword(String email) async {
    try {
      Response response = await dio
          .post(AppConstants.FORGET_PASSWORD_URI, data: {"email": email});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError('sdkj');
    }
  }
}
