// To parse this JSON data, do
//
//     final aboutYonetis = aboutYonetisFromJson(jsonString);

import 'dart:convert';

AboutYonetis aboutYonetisFromJson(String str) =>
    AboutYonetis.fromJson(json.decode(str));

String aboutYonetisToJson(AboutYonetis data) => json.encode(data.toJson());

class AboutYonetis {
  AboutYonetis({
    required this.websiteAddress,
    required this.termsOfServices,
    required this.privacyPolicy,
    required this.license,
  });

  String websiteAddress;
  String termsOfServices;
  String privacyPolicy;
  String license;

  factory AboutYonetis.fromJson(Map<String, dynamic> json) => AboutYonetis(
        websiteAddress: json["website_address"],
        termsOfServices: json["terms_of_services"],
        privacyPolicy: json["privacy_policy"],
        license: json["license"],
      );

  Map<String, dynamic> toJson() => {
        "website_address": websiteAddress,
        "terms_of_services": termsOfServices,
        "privacy_policy": privacyPolicy,
        "license": license,
      };
}
