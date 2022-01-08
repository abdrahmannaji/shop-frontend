import 'package:flutter/material.dart';
import 'package:mobailshop/data/model/base/api_response.dart';
import 'package:mobailshop/data/model/response/get_shop_model.dart';
import 'package:mobailshop/helper/api_checker.dart';
import 'package:mobailshop/provider/database.dart';
import 'package:mobailshop/repository/get_shop_repo.dart';

class GetShopProvider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  late Getshop_Repot getshop_repot;
  bool _status = false;
  // ignore: non_constant_identifier_names
  GetShopProvider({required this.getshop_repot});
  late GetShopModel _getShopMol;
  GetShopModel get getshop => _getShopMol;
  bool get status => _status;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Future<void> getShopList(BuildContext context) async {
    ApiResponse apiResponse = await getshop_repot.getShop();

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      print('apiResponse data');
      var map = apiResponse.response.data;

      // print("nzxhk${map["nameShop"]}");
      _getShopMol = GetShopModel.fromJson(apiResponse.response.data);
      getshop_repot.saveShopid(map["_id"]);
      getshop_repot.saveShopname(map["nameShop"]);
      _status = true;

      notifyListeners();
      Map<String, dynamic> userInfoMap = {
        "nameShop": map["nameShop"],
        "address": map["address"],
        "logo": map["logo"],
      };

      databaseMethods.addUserInfoToDB(map["_id"], userInfoMap);
    } else {
      print('apiResponse error');
      _status = false;

      ApiChecker.checkApi(context, apiResponse);
    }

    notifyListeners();
    // return data;
  }

  String getShopid() {
    return getshop_repot.getShopid();
  }

  String getShopname() {
    return getshop_repot.getShopname();
  }
  // Future<void> getLatestProductList(String offset, BuildContext context,
  //     {bool reload = false}) async {
  //   // if (!_offsetList.contains(offset)) {
  //   //   _offsetList.add(offset);
  //   ApiResponse apiResponse = await getshop_repot.getShop();
  //   if (apiResponse.response != null &&
  //       apiResponse.response.statusCode == 200) {
  // _latestProductList
  // .addAll(ProductModel.fromJson(apiResponse.response.data).product);
  // _latestPageSize =
  //     ProductModel.fromJson(apiResponse.response.data).totalPage;
  // _firstLoading = false;
  // _isLoading = false;
  //   } else {
  //     ApiChecker.checkApi(context, apiResponse);
  //   }
  //   notifyListeners();
  // }
  // else {
  //   if (_isLoading) {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
}
