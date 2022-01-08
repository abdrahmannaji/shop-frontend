import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobailshop/data/model/base/api_error_handler.dart';
import 'package:mobailshop/data/model/base/api_response.dart';
import 'package:mobailshop/main.dart';
import 'package:mobailshop/utill/app_constants.dart';

import 'auth_repo.dart';

class ProductRepo {
  Future<ApiResponse> getLatestProductList(String valueproduct) async {
    try {
      Response response = await dio.get(
          "${AppConstants.BASE_URL}api/v1/Product/$valueproduct",
          options: Options(headers: {'Authorization': 'Bearer $getUserToken'}));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getBrandOrCategoryProductList(
      bool isBrand, String id) async {
    try {
      String uri;
      if (isBrand) {
        uri = '${AppConstants.BRAND_PRODUCT_URI}$id';
      } else {
        uri = '${AppConstants.CATEGORY_PRODUCT_URI}$id';
      }
      final response = await dio.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getRelatedProductList(String id) async {
    try {
      final response = await dio.get(AppConstants.RELATED_PRODUCT_URI + id);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
