import 'dart:convert';

UsersModel sellerModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String sellerModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  UsersModel({
    required this.photoUrl,
    required this.id,
    required this.userType,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.verificationCode,
    required this.createdAt,
    required this.updatedAt,
  });

  String photoUrl;
  String id;
  String userType;
  String fName;
  String lName;
  String email;
  String phone;
  int verificationCode;
  DateTime createdAt;
  DateTime updatedAt;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        photoUrl: json["photoUrl"],
        id: json["_id"],
        userType: json["user_type"],
        fName: json["fName"],
        lName: json["lName"],
        email: json["email"],
        phone: json["phone"],
        verificationCode: json["verification_code"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "photoUrl": photoUrl,
        "_id": id,
        "user_type": userType,
        "fName": fName,
        "lName": lName,
        "email": email,
        "phone": phone,
        "verification_code": verificationCode,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
