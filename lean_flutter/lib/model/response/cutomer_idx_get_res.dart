// To parse this JSON data, do
//
//     final customersidxGetResponse = customersidxGetResponseFromJson(jsonString);

import 'dart:convert';

CustomersidxGetResponse customersidxGetResponseFromJson(String str) => CustomersidxGetResponse.fromJson(json.decode(str));

String customersidxGetResponseToJson(CustomersidxGetResponse data) => json.encode(data.toJson());

class CustomersidxGetResponse {
    int idx;
    String fullname;
    String phone;
    String email;
    String image;

    CustomersidxGetResponse({
        required this.idx,
        required this.fullname,
        required this.phone,
        required this.email,
        required this.image,
    });

    factory CustomersidxGetResponse.fromJson(Map<String, dynamic> json) => CustomersidxGetResponse(
        idx: json["idx"],
        fullname: json["fullname"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "idx": idx,
        "fullname": fullname,
        "phone": phone,
        "email": email,
        "image": image,
    };
}
