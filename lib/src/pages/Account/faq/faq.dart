// To parse this JSON data, do
//
//     final faq = faqFromMap(jsonString);

import 'dart:convert';

class Faq {
    Faq({
        this.title,
        this.id,
        this.context,
    });

    final String title;
    final String id;
    final List<Context> context;

    factory Faq.fromJson(String str) => Faq.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Faq.fromMap(Map<String, dynamic> json) => Faq(
        title: json["title"] == null ? null : json["title"],
        id: json["id"] == null ? null : json["id"],
        context: json["context"] == null ? null : List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "id": id == null ? null : id,
        "context": context == null ? null : List<dynamic>.from(context.map((x) => x.toMap())),
    };
}

class Context {
    Context({
        this.que,
        this.ans,
    });

    final String que;
    final String ans;

    factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Context.fromMap(Map<String, dynamic> json) => Context(
        que: json["que"] == null ? null : json["que"],
        ans: json["ans"] == null ? null : json["ans"],
    );

    Map<String, dynamic> toMap() => {
        "que": que == null ? null : que,
        "ans": ans == null ? null : ans,
    };
}
