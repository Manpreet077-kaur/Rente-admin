class AdvertisementResponse {
  int? status;
  String? message;
  List<AdvertisementData>? data;

  AdvertisementResponse({this.status, this.message, this.data});

  AdvertisementResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AdvertisementData>[];
      json['data'].forEach((v) {
        data!.add(new AdvertisementData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdvertisementData {
  String? sId;
  String? title;
  String? url;
  String? image;
  bool? status;
  int? iV;

  AdvertisementData({this.sId, this.title, this.url, this.image, this.status, this.iV});

  AdvertisementData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    url = json['url'];
    image = json['image'];
    status = json['status'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['url'] = this.url;
    data['image'] = this.image;
    data['status'] = this.status;
    data['__v'] = this.iV;
    return data;
  }
}