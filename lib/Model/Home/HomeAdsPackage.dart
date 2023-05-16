// To parse this JSON data, do
//
//     final homeMerchantCategories = homeMerchantCategoriesFromJson(jsonString);

import 'dart:convert';

HomePackagesDetail homeHomePackagesDetailFromJson(String str) =>
    HomePackagesDetail.fromJson(json.decode(str));

String homeHomePackagesDetailToJson(HomePackagesDetail data) =>
    json.encode(data.toJson());

class HomePackagesDetail {
  HomePackagesDetail({
    this.packagesDetails,
  });

  List<PackagesDetail>? packagesDetails;

  factory HomePackagesDetail.fromJson(Map<String, dynamic> json) =>
      HomePackagesDetail(
        packagesDetails: List<PackagesDetail>.from(
            json["packages"].map((x) => PackagesDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "packages": List<dynamic>.from(packagesDetails!.map((x) => x.toJson())),
      };
}

class PackagesDetail {
  PackagesDetail(
      {this.id, this.name, this.image, this.price, this.description});

  String? id;
  String? name;
  String? image;
  String? price;
  String? description;

  factory PackagesDetail.fromJson(Map<String, dynamic> json) => PackagesDetail(
        id: json['id'].toString(),
        name: json['name'],
        image: json['image'],
        price: json['price'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'price': price,
        'description': description
      };
}
