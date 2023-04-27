// To parse this JSON data, do
//
//     final marchantAllDetail = marchantAllDetailFromJson(jsonString);

class MarchantDetail {
  MarchantDetail({
    this.id,
    this.name,
    this.userType,
    this.businessType,
    this.phoneNum,
    this.website,
    this.address,
    this.businessStartTime,
    this.businessCloseTime,
    this.marchantLat,
    this.marchantLong,
    this.businessDetails,
    this.dob,
    this.avatar,
    this.coverPhoto,
    this.totalShares,
    this.totalReviews,
    this.totalPhotos,
    this.totalBookmarks,
    this.averageCost,
    this.orders,
    this.reviews,
    this.nearby,
  });

  String? id;
  String? name;
  String? userType;
  String? businessType;
  String? phoneNum;
  String? website;
  String? address;
  String? businessStartTime;
  String? businessCloseTime;
  String? marchantLat;
  String? marchantLong;
  String? businessDetails;
  DateTime? dob;
  String? avatar;
  String? coverPhoto;
  String? totalShares;
  String? totalReviews;
  String? totalPhotos;
  String? totalBookmarks;
  String? averageCost;
  List<Order>? orders;
  List<Reviews>? reviews;
  List<Nearby>? nearby;

  factory MarchantDetail.fromJson(Map<String, dynamic> json) => MarchantDetail(
        id: json["id"],
        name: json["name"],
        userType: json["user_type"],
        businessType: json["business_type"],
        phoneNum: json["phone_num"],
        website: json["website"],
        address: json["address"],
        businessStartTime: json["business_start_time"],
        businessCloseTime: json["business_close_time"],
        marchantLat: json["marchant_lat"],
        marchantLong: json["marchant_long"],
        businessDetails: json["business_details"],
        dob: DateTime.parse(json["dob"]),
        avatar: json["avatar"],
        coverPhoto: json["cover_photo"],
        totalShares: json["total_shares"].toString(),
        totalReviews: json["total_reviews"].toString(),
        totalPhotos: json["total_photos"].toString(),
        totalBookmarks: json["total_bookmarks"].toString(),
        averageCost: json["average_cost"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        reviews: List<Reviews>.from(json["reviews"].map((x) => Reviews.fromJson(x))),
        nearby: json["nearby"] == null ? [] : List<Nearby>.from(json["nearby"].map((x) => Nearby.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_type": userType,
        "business_type": businessType,
        "phone_num": phoneNum,
        "website": website,
        "address": address,
        "business_start_time": businessStartTime,
        "business_close_time": businessCloseTime,
        "marchant_lat": marchantLat,
        "marchant_long": marchantLong,
        "business_details": businessDetails,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "avatar": avatar,
        "cover_photo": coverPhoto,
        "total_shares": totalShares,
        "total_reviews": totalReviews,
        "total_photos": totalPhotos,
        "total_bookmarks": totalBookmarks,
        "average_cost": averageCost,
        "orders": List<dynamic>.from(orders!.map((x) => x)),
        "reviews": List<dynamic>.from(reviews!.map((x) => x)),
        "nearby": List<dynamic>.from(nearby!.map((x) => x.toJson())),
      };
}

class Nearby {
  Nearby({
    this.id,
    this.name,
    this.address,
    this.image,
    this.category,
  });

  String? id;
  String? name;
  String? address;
  String? image;
  String? category;

  factory Nearby.fromJson(Map<String, dynamic> json) => Nearby(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        image: json["image"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "image": image,
        "category": category,
      };
}

class Order {
  Order(
      {this.totalCount,
      this.date,
      this.bookingDate,
      this.startTime,
      this.endTime,
      this.orderStatus,
      this.orderDetails,
      this.booking_id,
      this.marchant_id,
      this.order_id});

  int? totalCount;
  String? date;
  String? bookingDate;
  String? startTime;
  String? order_id;
  String? booking_id;
  String? marchant_id;
  String? endTime;
  String? orderStatus;
  String? orderDetails;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        totalCount: json["total_count"],
        date: json["date"],
        bookingDate: json["booking_date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        orderStatus: json["order_status"],
        orderDetails: json["order_details"],
        order_id: json["order_id"],
        booking_id: json["booking_id"],
        marchant_id: json["marchant_id"],
      );

  Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "date": date,
        "booking_date": bookingDate,
        "start_time": startTime,
        "end_time": endTime,
        "order_status": orderStatus,
        "order_details": orderDetails,
        "order_id": order_id,
        "booking_id": booking_id,
        "marchant_id": marchant_id,
      };
}

class Reviews {
  Reviews({
    this.totalCount,
    this.avatar,
    this.date,
    this.name,
    this.comments,
  });

  int? totalCount;
  String? avatar;
  DateTime? date;
  String? name;
  String? comments;

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        totalCount: json["total_count"],
        avatar: json["avatar"],
        date: DateTime.parse(json["date"]),
        name: json["name"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "avatar": avatar,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "name": name,
        "comments": comments,
      };
}
