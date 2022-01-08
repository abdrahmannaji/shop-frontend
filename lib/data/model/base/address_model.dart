import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    this.id,
    this.customerId,
    this.contactPersonName,
    this.addressType,
    this.address,
    this.city,
    this.zip,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? customerId;
  String? contactPersonName;
  String? addressType;
  String? address;
  String? city;
  String? zip;
  String? phone;
  String? createdAt;
  String? updatedAt;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        customerId: json["customerId"],
        contactPersonName: json["contactPersonName"],
        addressType: json["addressType"],
        address: json["address"],
        city: json["city"],
        zip: json["zip"],
        phone: json["phone"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerId": customerId,
        "contactPersonName": contactPersonName,
        "addressType": addressType,
        "address": address,
        "city": city,
        "zip": zip,
        "phone": phone,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
