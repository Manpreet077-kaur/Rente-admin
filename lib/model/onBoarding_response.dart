class OnboardingResponse {
  int? status;
  String? message;
  List<OnBordingData>? data;

  OnboardingResponse({this.status, this.message, this.data});

  OnboardingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OnBordingData>[];
      json['data'].forEach((v) {
        data!.add(new OnBordingData.fromJson(v));
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

class OnBordingData {
  String? sId;
  String? image;
  String? title;
  String? description;
  int? iV;

  OnBordingData({this.sId, this.image, this.title, this.description, this.iV});

  OnBordingData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['description'] = this.description;
    data['__v'] = this.iV;
    return data;
  }
}
