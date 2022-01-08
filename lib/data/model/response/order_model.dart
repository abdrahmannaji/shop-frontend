import 'dart:convert';

import 'package:mobailshop/data/model/response/User_model.dart';
import 'package:mobailshop/data/model/response/get_shop_model.dart';
import 'package:mobailshop/data/model/response/product_model.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    required this.success,
    required this.ordres,
  });

  bool success;
  List<Ordre> ordres;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        success: json["success"],
        ordres: List<Ordre>.from(json["ordres"].map((x) => Ordre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "ordres": List<dynamic>.from(ordres.map((x) => x.toJson())),
      };
}

class Ordre {
  Ordre({
    required this.id,
    required this.usersModel,
    required this.productModel,
    required this.paymentStatus,
    required this.orderStatus,
    required this.paymentMethod,
    required this.orderAmount,
    required this.getShopModel,
    required this.deliveryStatus,
    required this.isStockDecreased,
    required this.createdAt,
    required this.ordresId,
  });

  String id;
  UsersModel usersModel;
  Product productModel;
  bool paymentStatus;
  String orderStatus;
  String paymentMethod;
  int orderAmount;
  ShopId getShopModel;
  String deliveryStatus;
  int isStockDecreased;
  DateTime createdAt;

  String ordresId;

  factory Ordre.fromJson(Map<String, dynamic> json) => Ordre(
        id: json["_id"],
        usersModel: UsersModel.fromJson(json["customer_id"]),
        productModel: Product.fromJson(json["product_id"]),
        paymentStatus: json["payment_status"],
        orderStatus: json["order_status"],
        paymentMethod: json["payment_method"],
        orderAmount: json["order_amount"],
        getShopModel: ShopId.fromJson(json["shop_id"]),
        deliveryStatus: json["delivery_status"],
        isStockDecreased: json["is_stock_decreased"],
        createdAt: DateTime.parse(json["createdAt"]),
        ordresId: json["id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customer_id": usersModel.toJson(),
        "product_id": productModel.toJson(),
        "payment_status": paymentStatus,
        "order_status": orderStatus,
        "payment_method": paymentMethod,
        "order_amount": orderAmount,
        "shop_id": getShopModel.toJson(),
        "delivery_status": deliveryStatus,
        "is_stock_decreased": isStockDecreased,
        "createdAt": createdAt.toIso8601String(),
        "id": ordresId,
      };
}

class ShopId {
  ShopId({
    required this.logo,
    this.shopCasingimage,
    required this.id,
    required this.userid,
    required this.nameShop,
    required this.address,
    required this.phone,
    this.facebook,
    this.twitter,
    this.youtube,
    this.instagram,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.subscriber,
    required this.shopIdId,
  });

  String logo;
  dynamic shopCasingimage;
  String id;
  String userid;
  String nameShop;
  String address;
  String phone;
  dynamic facebook;
  dynamic twitter;
  dynamic youtube;
  dynamic instagram;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int subscriber;
  String shopIdId;

  factory ShopId.fromJson(Map<String, dynamic> json) => ShopId(
        logo: json["logo"],
        shopCasingimage: json["shopCasingimage"],
        id: json["_id"],
        userid: json["userid"],
        nameShop: json["nameShop"],
        address: json["address"],
        phone: json["phone"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        youtube: json["youtube"],
        instagram: json["instagram"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        subscriber: json["subscriber"],
        shopIdId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "logo": logo,
        "shopCasingimage": shopCasingimage,
        "_id": id,
        "userid": userid,
        "nameShop": nameShop,
        "address": address,
        "phone": phone,
        "facebook": facebook,
        "twitter": twitter,
        "youtube": youtube,
        "instagram": instagram,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "subscriber": subscriber,
        "id": shopIdId,
      };
}
