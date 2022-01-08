import 'dart:convert';

ShopModel shopModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String shopModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
  ShopModel({
    this.userid,
    this.nameShop,
    this.address,
    this.phone,
    this.phone2,
    this.logo,
    this.shopCasingimage,
    this.facebook,
    this.twitter,
    this.youtube,
    this.instagram,
  });

  String? userid;
  String? nameShop;
  String? address;
  String? phone;
  String? phone2;
  String? logo;
  String? shopCasingimage;
  String? facebook;
  String? twitter;
  String? youtube;
  String? instagram;

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        userid: json["userid"],
        nameShop: json["nameShop"],
        address: json["address"],
        phone: json["phone"],
        phone2: json["phone2"],
        logo: json["logo"],
        shopCasingimage: json["shopCasingimage"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        youtube: json["youtube"],
        instagram: json["instagram"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "nameShop": nameShop,
        "address": address,
        "phone": phone,
        "phone2": phone2,
        "logo": logo,
        "shopCasingimage": shopCasingimage,
        "facebook": facebook,
        "twitter": twitter,
        "youtube": youtube,
        "instagram": instagram,
      };
}
