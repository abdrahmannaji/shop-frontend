import 'package:flutter/material.dart';
import 'package:mobailshop/data/model/body/otpmodeil.dart';
import 'package:mobailshop/data/model/response/response_model.dart';
import 'package:mobailshop/data/model/base/api_response.dart';
import 'package:mobailshop/data/model/base/error_response.dart';
import 'package:mobailshop/data/model/body/login_model.dart';
import 'package:mobailshop/data/model/body/register_model.dart';
import 'package:mobailshop/repository/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  AuthProvider({required this.authRepo});

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

  void updateRemember(bool value) {
    _isRemember = value;
    notifyListeners();
  }

  Future registration(RegisterModel register, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.registration(register);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;

      authRepo.saveUserType(map["usertype"]);
      authRepo.saveUserid(map["id"]);
      // await authRepo.updateToken();
      callback(true, 'token');
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

  Future verificationCode(OtpModel otpModel, Function callback) async {
    _isLoading = true;
    notifyListeners();

    ApiResponse apiResponse = await authRepo.verificationCode(otpModel);

    _isLoading = false;

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      String token = map["token"];
      print(token);
      authRepo.saveUserToken(token);
      callback(true, token);
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

  Future login(LoginModel loginBody, Function callback) async {
    _isLoading = true;
    notifyListeners();

    ApiResponse apiResponse = await authRepo.login(loginBody);
    // print("hh${apiResponse.response.statusCode}");
    _isLoading = false;

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      String token = map["token"];
      String userType = map["usertype"];

      authRepo.saveUserToken(token);
      authRepo.saveUserid(map["id"]);
      authRepo.saveUserType(userType);

      // await authRepo.updateToken();
      callback(true, token);
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

  // Future<void> updateToken(BuildContext context) async {
  //   // ApiResponse apiResponse = await authRepo.updateToken();
  //   if (apiResponse.response != null &&
  //       apiResponse.response.statusCode == 200) {
  //   } else {
  //     ApiChecker.checkApi(context, apiResponse);
  //   }
  // }

  // for user Section

  String getUserType() {
    return authRepo.getUserType();
  }

  bool isUserType() {
    return authRepo.isUserType();
  }

  String getUserid() {
    return authRepo.getUserid();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  // for  Remember Email
  void saveUserEmail(String email, String password) {
    authRepo.saveUserEmailAndPassword(email, password);
  }

  String getUserEmail() {
    return authRepo.getUserEmail();
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo.clearUserEmailAndPassword();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }

  Future<ResponseModel> forgetPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.forgetPassword(email);
    _isLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response.data["message"], true);
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
      responseModel = ResponseModel(errorMessage, false);
    }
    return responseModel;
  }
}
