import 'dart:convert';

GetShopModel getShopModelFromJson(String str) =>
    GetShopModel.fromJson(json.decode(str));

String getShopModelToJson(GetShopModel data) => json.encode(data.toJson());

class GetShopModel {
  GetShopModel({
    required this.logo,
    this.shopCasingimage,
    required this.id,
    this.userid,
    required this.nameShop,
    required this.address,
    required this.phone,
    this.facebook,
    this.twitter,
    required this.youtube,
    required this.instagram,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.subscriber,
    required this.getShopModelId,
  });

  String logo;
  dynamic shopCasingimage;
  String id;
  Userid? userid;
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
  String getShopModelId;

  factory GetShopModel.fromJson(Map<String, dynamic> json) => GetShopModel(
        logo: json["logo"],
        shopCasingimage: json["shopCasingimage"],
        id: json["_id"],
        userid: Userid.fromJson(json["userid"]),
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
        subscriber: json["subscriber"] ?? "",
        getShopModelId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "logo": logo,
        "shopCasingimage": shopCasingimage,
        "_id": id,
        "userid": userid!.toJson(),
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
        "id": getShopModelId,
      };
}

class Userid {
  Userid({
    required this.id,
    required this.userType,
    required this.fName,
    this.photoUrl,
    required this.lName,
    required this.email,
    required this.phone,
    required this.verificationCode,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.useridId,
  });

  String id;
  String userType;
  String fName;
  String lName;
  String? photoUrl;
  String email;
  String phone;
  int verificationCode;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String useridId;

  factory Userid.fromJson(Map<String, dynamic> json) => Userid(
        id: json["_id"],
        userType: json["user_type"],
        fName: json["fName"],
        lName: json["lName"],
        photoUrl: json["photoUrl"] ?? "",
        email: json["email"],
        phone: json["phone"],
        verificationCode: json["verification_code"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        useridId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_type": userType,
        "fName": fName,
        "lName": lName,
        "email": email,
        "photoUrl": photoUrl,
        "phone": phone,
        "verification_code": verificationCode,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": useridId,
      };
}
