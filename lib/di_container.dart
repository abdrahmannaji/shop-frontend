import 'package:dio/dio.dart';
import 'package:mobailshop/provider/addproduct_provider.dart';
import 'provider/get_shop_provider.dart';
import 'package:mobailshop/provider/order_provider.dart';
import 'package:mobailshop/provider/product_provider.dart';
import 'package:mobailshop/repository/addproduc_repo.dart';
import 'package:mobailshop/repository/get_shop_repo.dart';
import 'package:mobailshop/repository/order_repo.dart';
import 'package:mobailshop/repository/product_repo.dart';
import 'package:mobailshop/repository/profile_repo.dart';
import 'package:mobailshop/repository/shop_repo.dart';
import 'package:mobailshop/provider/auth_provider.dart';
import 'package:mobailshop/provider/localization_provider.dart';
import 'package:mobailshop/provider/shop_provder.dart';
import 'provider/profile_provider.dart';
import 'package:mobailshop/provider/theme_provider.dart';

import 'package:get_it/get_it.dart';
import 'package:mobailshop/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repository/auth_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Repository
  sl.registerLazySingleton(() => ProfileRepo(sharedPreferences: sl()));

  sl.registerLazySingleton(() => AddproductRepot(sharedPreferences: sl()));
  sl.registerLazySingleton(() => AuthRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => OrderListRepo());
  sl.registerLazySingleton(() => ShopRepo(
        sharedPreferences: sl(),
      ));
  sl.registerLazySingleton(() => Getshop_Repot(sharedPreferences: sl()));
  sl.registerLazySingleton(() => ProductRepo());

  // Provider
  sl.registerLazySingleton(() => AddproductProvider(addproductRepot: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => ProductProvider(productRepo: sl()));
  sl.registerFactory(() => OrderProvider(orderListRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => GetShopProvider(getshop_repot: sl()));

  sl.registerFactory(() => ShopProvider(
        shopRepo: sl(),
      ));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}
