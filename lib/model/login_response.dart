class LoginResponse {
  int? status;
  String? message;
  Data? data;

  LoginResponse({this.status, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? email;
  String? password;
  String? profileImage;
  int? iV;
  String? firstName;
  String? token;

  Data(
      {this.sId,
        this.email,
        this.password,
        this.profileImage,
        this.iV,
        this.firstName,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    profileImage = json['profileImage'];
    iV = json['__v'];
    firstName = json['firstName'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['profileImage'] = this.profileImage;
    data['__v'] = this.iV;
    data['firstName'] = this.firstName;
    data['token'] = this.token;
    return data;
  }
}