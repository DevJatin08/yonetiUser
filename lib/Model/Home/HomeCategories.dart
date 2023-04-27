// To parse this JSON data, do
//
//     final homeCategories = homeCategoriesFromJson(jsonString);

import 'dart:convert';

HomeCategories homeCategoriesFromJson(String str) => HomeCategories.fromJson(json.decode(str));

String homeCategoriesToJson(HomeCategories data) => json.encode(data.toJson());

class HomeCategories {
    HomeCategories({
        this.username,
        this.avatar,
        this.categories,
    });

    String? username;
    String? avatar;
    List<Category>? categories;

    factory HomeCategories.fromJson(Map<String, dynamic> json) => HomeCategories(
        username: json["username"],
        avatar: json["avatar"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "avatar": avatar,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        this.id,
        this.name,
        this.image,
        this.cnt,
    });

    String? id;
    String? name;
    String? image;
    var cnt;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        cnt: json["CNT"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "CNT": cnt,
    };
}
