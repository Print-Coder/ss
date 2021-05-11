// To parse this JSON data, do
//
//     final cities = citiesFromMap(jsonString);

import 'dart:convert';

class Cities {
    Cities({
        this.city,
        this.state,
    });

    final String city;
    final String state;

    factory Cities.fromJson(String str) => Cities.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Cities.fromMap(Map<String, dynamic> json) => Cities(
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
    );

    Map<String, dynamic> toMap() => {
        "city": city == null ? null : city,
        "state": state == null ? null : state,
    };
}
