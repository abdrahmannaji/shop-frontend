import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    required this.phone,
    required this.id,
    required this.ram,
    required this.status,
    required this.color,
    required this.rom,
    required this.v,
  });

  Phone phone;
  String id;
  String ram;
  String status;
  String color;
  String rom;
  int v;

  static List<UserModel> fromJsonList(List list) {
    return list.map((item) => UserModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  bool? userFilterByCreationDate(String filter) {
    return this.phone.phonetypes.phonetype.toString().contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(UserModel? model) {
    return this.id == model?.id;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        phone: Phone.fromJson(json["phone"]),
        id: json["_id"],
        ram: json["ram"],
        status: json["status"],
        color: json["color"],
        rom: json["rom"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone.toJson(),
        "_id": id,
        "ram": ram,
        "status": status,
        "color": color,
        "rom": rom,
        "__v": v,
      };
}

class Phone {
  Phone({
    required this.names,
    required this.phonetypes,
    required this.logophonne,
  });

  Names names;
  Phonetypes phonetypes;
  String logophonne;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        names: Names.fromJson(json["names"]),
        phonetypes: Phonetypes.fromJson(json["phonetypes"]),
        logophonne: json["logophonne"],
      );

  Map<String, dynamic> toJson() => {
        "names": names.toJson(),
        "phonetypes": phonetypes.toJson(),
        "logophonne": logophonne,
      };
}

class Names {
  Names({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Names.fromJson(Map<String, dynamic> json) => Names(
        id: json["id"] == null ? '' : json["id"],
        name: json["name"] == null ? '' : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Phonetypes {
  Phonetypes({
    required this.id,
    required this.phonetype,
  });

  int id;
  String? phonetype;

  factory Phonetypes.fromJson(Map<String, dynamic> json) => Phonetypes(
        id: json["id"],
        phonetype: json["phonetype"] != null ? json["phonetype"] : '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phonetype": phonetype != null ? phonetype : '',
      };
}
