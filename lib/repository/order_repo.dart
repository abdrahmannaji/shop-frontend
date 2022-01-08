import 'package:dio/dio.dart';
import 'package:mobailshop/UI/addproduct/addproduct_screen.dart';
import 'package:mobailshop/data/model/base/api_error_handler.dart';
import 'package:mobailshop/data/model/base/api_response.dart';
import 'package:mobailshop/repository/auth_repo.dart';
import 'package:mobailshop/utill/app_constants.dart';

class OrderListRepo {
  Future<ApiResponse> getOrderList() async {
    try {
      final response =
          await dio.get("${AppConstants.BASE_URL}api/v1/ordres/$shopid");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderDetails(String orderID) async {
    try {
      final response = await dio.get(AppConstants.BASE_URL + orderID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> orderStatus(String orderID, String orderStatus) async {
    try {
      Response response = await dio.put(
        '${AppConstants.BASE_URL}api/v1/ordres/$orderID',
        data: {"order_status": orderStatus},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderStatusList() async {
    try {
      List<String> addressTypeList = [
        'Select Order Status',
        'pending',
        'processing',
        'delivered',
        'return',
        'failed',
      ];
      Response response = Response(
          requestOptions: RequestOptions(path: ''),
          data: addressTypeList,
          statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
