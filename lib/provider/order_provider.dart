import 'package:flutter/material.dart';
import 'package:mobailshop/data/model/base/api_response.dart';
import 'package:mobailshop/data/model/base/error_response.dart';

import 'package:mobailshop/data/model/response/order_model.dart';
import 'package:mobailshop/data/model/response/response_model.dart';
import 'package:mobailshop/helper/api_checker.dart';
import 'package:mobailshop/repository/order_repo.dart';
import 'package:mobailshop/utill/app_constants.dart';

class OrderProvider extends ChangeNotifier {
  final OrderListRepo orderListRepo;
  OrderProvider({required this.orderListRepo});

  late List<Ordre> _orderList;
  List<Ordre> get orderList => _orderList;
  late List<Ordre> _pendingList;
  late List<Ordre> _processing;
  late List<Ordre> _deliveredList;
  late List<Ordre> _returnList;
  late List<Ordre> _canceledList;
  List<Ordre> get pendingList => _pendingList;
  List<Ordre> get processing => _processing;
  List<Ordre> get deliveredList => _deliveredList;
  List<Ordre> get returnList => _returnList;
  List<Ordre> get canceledList => _canceledList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _orderTypeIndex = 0;
  int get orderTypeIndex => _orderTypeIndex;

  List<String> _orderStatusList = [];
  String _orderStatusType = '';
  List<String> get orderStatusList => _orderStatusList;
  String get orderStatusType => _orderStatusType;

  String? _addOrderStatusErrorText;
  String? get addOrderStatusErrorText => _addOrderStatusErrorText;

  late List<String> _paymentImageList;
  List<String> get paymentImageList => _paymentImageList;

  int _paymentMethodIndex = 0;
  int get paymentMethodIndex => _paymentMethodIndex;

  void setOrderStatusErrorText(String errorText) {
    _addOrderStatusErrorText = errorText;
    notifyListeners();
  }

  Future<ResponseModel> updateOrderStatus(
    String orderIDs,
    String orderStatus,
  ) async {
    _isLoading = false;
    notifyListeners();

    ResponseModel responseModel;
    late ApiResponse apiResponse;
    // for (int id in orderIDs) {}

    apiResponse = await orderListRepo.orderStatus(orderIDs, orderStatus);
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      String message = apiResponse.response.data.toString();
      responseModel = ResponseModel(message, true);
      _addOrderStatusErrorText = message;
      _isLoading = true;
    } else {
      String errorMessage = apiResponse.error.toString();
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.error);
        errorMessage = errorResponse.error;
      }
      _addOrderStatusErrorText = errorMessage;
      responseModel = ResponseModel(errorMessage, false);
    }
    notifyListeners();
    return responseModel;
  }

  Future<void> getOrder(BuildContext context) async {
    ApiResponse apiResponse = await orderListRepo.getOrderList();

    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _orderList = [];
      _pendingList = [];
      _processing = [];
      _deliveredList = [];
      _returnList = [];
      _canceledList = [];
      print(_pendingList);
      print(_pendingList);
      OrderModel orderModel = OrderModel.fromJson(apiResponse.response.data);
      for (int i = 0; i < orderModel.ordres.length; i++) {
        _orderList.add(orderModel.ordres[i]);
        _isLoading = true;
        if (orderModel.ordres[i].orderStatus == AppConstants.PENDING ||
            orderModel.ordres[i].orderStatus == AppConstants.CONFIRMED) {
          _pendingList.add(orderModel.ordres[i]);
          _isLoading = true;
        } else if (orderModel.ordres[i].orderStatus ==
                AppConstants.PROCESSING ||
            orderModel.ordres[i].orderStatus == AppConstants.PROCESSED) {
          _processing.add(orderModel.ordres[i]);
        } else if (orderModel.ordres[i].orderStatus == AppConstants.DELIVERED) {
          _deliveredList.add(orderModel.ordres[i]);
        } else if (orderModel.ordres[i].orderStatus == AppConstants.RETURNED) {
          _returnList.add(orderModel.ordres[i]);
        } else if (orderModel.ordres[i].orderStatus == AppConstants.CANCELLED ||
            orderModel.ordres[i].orderStatus == AppConstants.FAILED) {
          _canceledList.add(orderModel.ordres[i]);
        }
      }
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void setIndex(int index) {
    _orderTypeIndex = index;
    notifyListeners();
  }

  void initOrderStatusList(BuildContext context) async {
    ApiResponse apiResponse = await orderListRepo.getOrderStatusList();
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _orderStatusList.clear();
      _orderStatusList.addAll(apiResponse.response.data);
      _orderStatusType = apiResponse.response.data[0];
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void updateStatus(String? value) {
    _orderStatusType = value!;
    notifyListeners();
  }

  void setPaymentMethodIndex(int index) {
    _paymentMethodIndex = index;
    notifyListeners();
  }
}
