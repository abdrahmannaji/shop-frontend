import 'dart:convert';

AddproductModile addproductModileFromJson(String str) =>
    AddproductModile.fromJson(json.decode(str));

String addproductModileToJson(AddproductModile data) =>
    json.encode(data.toJson());

class AddproductModile {
  AddproductModile({
    this.name,
    this.shopid,
    this.typePhone,
    this.phoneSize,
    this.phoneWeight,
    this.batteryCapacity,
    this.phoneVersion,
    this.colors,
    this.status,
    this.rem,
    this.rom,
    this.unitPrice,
    this.quantity,
    this.purchasePrice,
    this.tax,
    this.dscount,
    this.img,
    this.description,
  });

  String? name;
  String? shopid;
  String? typePhone;
  String? phoneSize;
  String? phoneWeight;
  String? batteryCapacity;
  String? phoneVersion;
  String? colors;
  String? status;
  String? rem;
  String? rom;
  int? unitPrice;
  int? quantity;
  int? purchasePrice;
  int? tax;
  List<String>? img;
  int? dscount;
  String? description;

  factory AddproductModile.fromJson(Map<String, dynamic> json) =>
      AddproductModile(
        name: json["name"],
        shopid: json["shopid"],
        typePhone: json["type_phone"],
        phoneSize: json["phone_size"],
        phoneWeight: json["phone_Weight"],
        batteryCapacity: json["battery_capacity"],
        phoneVersion: json["Phone_version"],
        colors: json["colors"],
        status: json["status"],
        rem: json["rem"],
        rom: json["rom"],
        unitPrice: json["unit_price"],
        quantity: json["quantity"],
        purchasePrice: json["purchase_price"],
        tax: json["tax"],
        dscount: json["dscount"],
        img: List<String>.from(json["img"].map((x) => x)),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "shopid": shopid,
        "type_phone": typePhone,
        "phone_size": phoneSize,
        "phone_Weight": phoneWeight,
        "battery_capacity": batteryCapacity,
        "Phone_version": phoneVersion,
        "colors": colors,
        "status": status,
        "rem": rem,
        "rom": rom,
        "unit_price": unitPrice,
        "quantity": quantity,
        "purchase_price": purchasePrice,
        "tax": tax,
        "dscount": dscount,
        "img": List<dynamic>.from(img!.map((x) => x)),
        "Description": description,
      };
}
