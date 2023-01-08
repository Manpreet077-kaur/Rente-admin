class DashboardResponse {
  int? status;
  String? message;
  Data? data;

  DashboardResponse({this.status, this.message, this.data});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
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
  int? totalUsersInApp;
  int? payment;

  Data({this.totalUsersInApp, this.payment});

  Data.fromJson(Map<String, dynamic> json) {
    totalUsersInApp = json['totalUsersInApp'];
    payment = json['payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalUsersInApp'] = this.totalUsersInApp;
    data['payment'] = this.payment;
    return data;
  }
}