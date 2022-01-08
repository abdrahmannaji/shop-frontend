import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.lName,
    this.userType,
    this.fName,
    this.email,
    this.password,
    this.address,
    this.phone,
    this.photoUrl,
    this.shopCasingimage,
    this.country,
    this.city,
  });

  String? userType;
  String? lName;
  String? fName;
  String? email;
  String? password;
  String? address;
  String? phone;
  String? photoUrl;
  String? shopCasingimage;
  String? country;
  String? city;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        userType: json["user_type"],
        lName: json["lName"],
        fName: json["fName"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        phone: json["phone"],
        photoUrl: json["photoUrl"],
        shopCasingimage: json["shopCasingimage"],
        country: json["country"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "user_type": userType,
        "lName": lName,
        "fName": fName,
        "email": email,
        "password": password,
        "address": address,
        "phone": phone,
        "photoUrl": photoUrl,
        "shopCasingimage": shopCasingimage,
        "country": country,
        "city": city,
      };
}
