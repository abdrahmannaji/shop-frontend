import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  OtpModel({
    this.id,
    this.verificationCode,
  });

  String? id;
  int? verificationCode;

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        id: json["_id"],
        verificationCode: json["verification_code"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "verification_code": verificationCode,
      };
}
