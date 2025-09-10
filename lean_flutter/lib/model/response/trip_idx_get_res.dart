// To parse this JSON data, do
//
//     final tripsidxGetResponse = tripsidxGetResponseFromJson(jsonString);

import 'dart:convert';

TripsidxGetResponse tripsidxGetResponseFromJson(String str) => TripsidxGetResponse.fromJson(json.decode(str));

String tripsidxGetResponseToJson(TripsidxGetResponse data) => json.encode(data.toJson());

class TripsidxGetResponse {
    int idx;
    String name;
    String country;
    String coverimage;
    String detail;
    int price;
    int duration;
    String destinationZone;

    TripsidxGetResponse({
        required this.idx,
        required this.name,
        required this.country,
        required this.coverimage,
        required this.detail,
        required this.price,
        required this.duration,
        required this.destinationZone,
    });

    factory TripsidxGetResponse.fromJson(Map<String, dynamic> json) => TripsidxGetResponse(
        idx: json["idx"],
        name: json["name"],
        country: json["country"],
        coverimage: json["coverimage"],
        detail: json["detail"],
        price: json["price"],
        duration: json["duration"],
        destinationZone: json["destination_zone"],
    );

    Map<String, dynamic> toJson() => {
        "idx": idx,
        "name": name,
        "country": country,
        "coverimage": coverimage,
        "detail": detail,
        "price": price,
        "duration": duration,
        "destination_zone": destinationZone,
    };
}
