// To parse this JSON data, do
//
//     final customerRegisterPostRequest = customerRegisterPostRequestFromJson(jsonString);

import 'dart:convert';

CustomerRegisterPostRequest customerRegisterPostRequestFromJson(String str) => CustomerRegisterPostRequest.fromJson(json.decode(str));

String customerRegisterPostRequestToJson(CustomerRegisterPostRequest data) => json.encode(data.toJson());

class CustomerRegisterPostRequest {
    String message;
    int id;

    CustomerRegisterPostRequest({
        required this.message,
        required this.id,
    });

    factory CustomerRegisterPostRequest.fromJson(Map<String, dynamic> json) => CustomerRegisterPostRequest(
        message: json["message"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
    };
}
