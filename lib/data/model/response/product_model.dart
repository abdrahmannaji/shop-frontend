// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.success,
    required this.count,
    required this.totalPage,
    // required this.pagination,
    required this.product,
  });

  bool success;
  int count;
  int totalPage;
  // Pagination pagination;
  List<Product> product;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        success: json["success"],
        count: json["count"] ?? 0,
        totalPage: json["totalPage"] ?? 0,
        // pagination: Pagination.fromJson(json["pagination"]),
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "totalPage": totalPage,
        // "pagination": pagination.toJson(),
        "data": List<Product>.from(product.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.img,
    required this.quantity,
    required this.mainimage,
    required this.unitPrice,
    required this.dscount,
    required this.purchasePrice,
    required this.tax,
    required this.ratingAvg,
    required this.isApproved,
    required this.id,
    required this.name,
    required this.shopId,
    required this.typePhone,
    required this.phoneSize,
    required this.phoneWeight,
    required this.batteryCapacity,
    required this.phoneVersion,
    required this.colors,
    required this.rom,
    required this.colorimg,
    required this.status,
    required this.approvedOn,
    required this.updatedAt,
    required this.createdAt,
    required this.v,
  });

  List<String> img;
  int quantity;
  int unitPrice;
  int purchasePrice;
  int tax;
  int dscount;
  int ratingAvg;
  bool isApproved;
  String id;
  String colorimg;
  String name;
  String mainimage;
  String shopId;
  String typePhone;
  String phoneSize;
  String phoneWeight;
  String batteryCapacity;
  String phoneVersion;
  String colors;
  String rom;
  String status;
  DateTime approvedOn;
  DateTime updatedAt;
  DateTime createdAt;
  int v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        img: List<String>.from(json["img"].map((x) => x)),
        quantity: json["quantity"],
        unitPrice: json["unit_price"],
        dscount: json["dscount"],
        mainimage: json["mainimage"] ?? "",
        purchasePrice: json["purchase_price"],
        tax: json["tax"],
        ratingAvg: json["rating_avg"],
        isApproved: json["is_approved"],
        id: json["_id"],
        name: json["name"],
        shopId: json["shop_id"] == null ? '' : json["shop_id"],
        typePhone: json["type_phone"],
        phoneSize: json["phone_size"],
        phoneWeight: json["phone_Weight"],
        batteryCapacity: json["battery_capacity"],
        phoneVersion: json["Phone_version"],
        colors: json["colors"] ?? '',
        rom: json["rom"],
        colorimg: json["colorimg"] ?? "",
        status: json["status"],
        approvedOn: DateTime.parse(json["approved_on"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "img": List<dynamic>.from(img.map((x) => x)),
        "quantity": quantity,
        "unit_price": unitPrice,
        "purchase_price": purchasePrice,
        "tax": tax,
        "mainimage": mainimage,
        "rating_avg": ratingAvg,
        "is_approved": isApproved,
        "_id": id,
        "dscount": dscount,
        "name": name,
        "colorimg": colorimg,
        "shop_id": shopId,
        "type_phone": typePhone,
        "phone_size": phoneSize,
        "phone_Weight": phoneWeight,
        "battery_capacity": batteryCapacity,
        "Phone_version": phoneVersion,
        "colors": colors,
        "rom": rom,
        "status": status,
        "approved_on": approvedOn.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
