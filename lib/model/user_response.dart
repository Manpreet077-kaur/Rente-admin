class UserResponse {
  int? status;
  String? message;
  List<UserData>? data;

  UserResponse({this.status, this.message, this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add(new UserData.fromJson(v));
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

class UserData {
  bool? isActive;
  bool? createdByAdmin;
  bool? deletedByAdmin;
  bool? isDocumentVerified;
  String? sId;
  String? name;
  String? email;
  int? phoneNumber;
  String? countryCode;
  int? userType;
  List<String>? idCardImage;
  List<String>? passportImage;
  bool? isphoneVerified;
  int? iV;
  int? dob;
  String? gender;
  String? profilePicture;
  double? lattitude;
  double? longitude;
  bool? blockedByAdmin;
  bool? isUserVerifiedByAdmin;
  bool? isDocumentUploaded;
  String? createdAt;

  UserData(
      {this.isActive,
        this.createdByAdmin,
        this.deletedByAdmin,
        this.isDocumentVerified,
        this.sId,
        this.name,
        this.email,
        this.phoneNumber,
        this.countryCode,
        this.userType,
        this.idCardImage,
        this.passportImage,
        this.isphoneVerified,
        this.iV,
        this.dob,
        this.gender,
        this.profilePicture,
        this.lattitude,
        this.longitude,
        this.blockedByAdmin,
        this.isUserVerifiedByAdmin,
        this.isDocumentUploaded,
        this.createdAt});

  UserData.fromJson(Map<String, dynamic> json) {
    isActive = json['is_Active'];
    createdByAdmin = json['created_By_Admin'];
    deletedByAdmin = json['deleted_By_Admin'];
    isDocumentVerified = json['is_document_verified'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
    userType = json['user_type'];
    idCardImage = json['id_card_image'].cast<String>();
    passportImage = json['passport_image'].cast<String>();
    isphoneVerified = json['isphone_verified'];
    iV = json['__v'];
    dob = json['dob'];
    gender = json['gender'];
    profilePicture = json['profile_picture'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    blockedByAdmin = json['blocked_by_admin'];
    isUserVerifiedByAdmin = json['is_user_verified_by_admin'];
    isDocumentUploaded = json['is_document_uploaded'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_Active'] = this.isActive;
    data['created_By_Admin'] = this.createdByAdmin;
    data['deleted_By_Admin'] = this.deletedByAdmin;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['country_code'] = this.countryCode;
    data['user_type'] = this.userType;
    data['id_card_image'] = this.idCardImage;
    data['passport_image'] = this.passportImage;
    data['isphone_verified'] = this.isphoneVerified;
    data['__v'] = this.iV;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profile_picture'] = this.profilePicture;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['blocked_by_admin'] = this.blockedByAdmin;
    data['is_user_verified_by_admin'] = this.isUserVerifiedByAdmin;
    data['is_document_uploaded'] = this.isDocumentUploaded;
    data['created_at'] = this.createdAt;
    return data;
  }
}