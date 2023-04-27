class TopPhotosData {
  List<Photos> photos = <Photos>[];

  TopPhotosData({required this.photos});

  TopPhotosData.fromJson(Map<String, dynamic> json) {
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photos'] = this.photos.map((v) => v.toJson()).toList();
    return data;
  }
}

class Photos {
  String? id;
  String? user_id;
  String? image;
  String? total_likes;
  String? total_photos;

  Photos({
    this.id,
    this.user_id,
    this.image,
    this.total_likes,
    this.total_photos,
  });

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    image = json['name'];
    total_likes = json['total_likes'];
    total_photos = json['total_photos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.user_id;
    data['name'] = this.image;
    data['total_likes'] = this.total_likes;
    data['total_photos'] = this.total_photos;
    return data;
  }
}
