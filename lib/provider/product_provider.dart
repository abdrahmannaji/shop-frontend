import 'package:flutter/material.dart';
import 'package:mobailshop/data/model/base/api_response.dart';
import 'package:mobailshop/data/model/response/product_model.dart';
import 'package:mobailshop/helper/api_checker.dart';
import 'package:mobailshop/repository/product_repo.dart';

class ProductProvider extends ChangeNotifier {
  ProductRepo productRepo;
  ProductProvider({
    required this.productRepo,
  });

  // Latest products
  ProductModel? _latestProductList;
  late bool _isLoading = false;
  late bool _firstLoading = true;
  late int _latestPageSize;
  // late List<String> _offsetList = [];

  ProductModel get latestProductList => _latestProductList!;
  bool get isLoading => _isLoading;
  bool get firstLoading => _firstLoading;
  int get latestPageSize => _latestPageSize;

  Future<void> getLatestProductList(
      BuildContext context, String valueproduct) async {
    // {bool reload = false}
    // if (reload) {
    //   _offsetList = [];
    //   // _latestProductList;
    // }
    // if (!_offsetList.contains(offset)) {
    //   _offsetList.add(offset);
    print('ghjhdok');
    ApiResponse apiResponse =
        await productRepo.getLatestProductList(valueproduct);
    if (apiResponse.response.data['success'] == true &&
        apiResponse.response.statusCode == 200) {
      print('ghjhd');
      _latestProductList = ProductModel.fromJson(apiResponse.response.data);
      // _latestPageSize = ProductModel.fromJson(apiResponse.response.data).count;
      _firstLoading = false;
      _isLoading = false;
      notifyListeners();
    } else {
      print('eroor');
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    // } else {
    //   if (_isLoading) {
    // _isLoading = false;
    //     notifyListeners();
    // }
    // }
  }

  Future<int> getLatestOffset(valueproduct) async {
    ApiResponse apiResponse =
        await productRepo.getLatestProductList(valueproduct);
    return ProductModel.fromJson(apiResponse.response.data).totalPage;
  }

  void showBottomLoader() {
    _isLoading = true;
    notifyListeners();
  }

  void removeFirstLoading() {
    _firstLoading = true;
    notifyListeners();
  }

  // Seller products
  late List<Product> _sellerAllProductList = [];
  late List<Product> _sellerProductList = [];
  late int _sellerPageSize;
  List<Product> get sellerProductList => _sellerProductList;
  int get sellerPageSize => _sellerPageSize;

  // void initSellerProductList(
  //     String sellerId, String offset, BuildContext context) async {
  //   ApiResponse apiResponse =
  //       await productRepo.getSellerProductList(sellerId, offset);
  //   if (apiResponse.response != null &&
  //       apiResponse.response.statusCode == 200) {
  //     _sellerProductList
  //         .addAll(ProductModel.fromJson(apiResponse.response.data).data);
  //     _sellerAllProductList
  //         .addAll(ProductModel.fromJson(apiResponse.response.data).data);
  //     _sellerPageSize =
  //         ProductModel.fromJson(apiResponse.response.data).totalPage;
  //     _firstLoading = false;
  //     _isLoading = false;
  //   } else {
  //     ApiChecker.checkApi(context, apiResponse);
  //   }
  //   notifyListeners();
  // }

  void filterData(String newText) {
    _sellerProductList.clear();
    if (newText.isNotEmpty) {
      _sellerAllProductList.forEach((product) {
        if (product.name.toLowerCase().contains(newText.toLowerCase())) {
          _sellerProductList.add(product);
        }
      });
    } else {
      _sellerProductList.clear();
      _sellerProductList.addAll(_sellerAllProductList);
    }
    notifyListeners();
  }

  void clearSellerData() {
    _sellerProductList = [];
    notifyListeners();
  }

  // Brand and category products
  List<Product> _brandOrCategoryProductList = [];
  late bool _hasData;

  List<Product> get brandOrCategoryProductList => _brandOrCategoryProductList;
  bool get hasData => _hasData;

  void initBrandOrCategoryProductList(
      bool isBrand, String id, BuildContext context) async {
    _brandOrCategoryProductList.clear();
    _hasData = true;
    ApiResponse apiResponse =
        await productRepo.getBrandOrCategoryProductList(isBrand, id);
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      apiResponse.response.data.forEach((product) =>
          _brandOrCategoryProductList.add(Product.fromJson(product)));
      _hasData = _brandOrCategoryProductList.length > 1;
      List<Product> _products = [];
      _products.addAll(_brandOrCategoryProductList);
      _brandOrCategoryProductList.clear();
      _brandOrCategoryProductList.addAll(_products.reversed);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  // Related products
  late List<Product> _relatedProductList;
  List<Product> get relatedProductList => _relatedProductList;

  void initRelatedProductList(String id, BuildContext context) async {
    ApiResponse apiResponse = await productRepo.getRelatedProductList(id);
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      _relatedProductList = [];
      apiResponse.response.data.forEach(
          (product) => _relatedProductList.add(Product.fromJson(product)));
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  void removePrevRelatedProduct() {
    _relatedProductList = [];
  }
}
