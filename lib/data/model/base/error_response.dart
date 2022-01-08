import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    required this.success,
    required this.error,
  });

  bool success;
  String error;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        success: json["success"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
      };
}

// ErrorResponse errorResponseFromJson(String str) =>
//     ErrorResponse.fromJson(json.decode(str));

// String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

// class ErrorResponse {
//   ErrorResponse({
//     required this.errors,
//   });

//   List<Error> errors;

//   factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
//         errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
//       };
// }

// class Error {
//   Error({
//     required this.code,
//     required this.message,
//   });

//   String code;
//   String message;

//   factory Error.fromJson(Map<String, dynamic> json) => Error(
//         code: json["code"],
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "message": message,
//       };
// }
