class PropertyResponse {
  int? status;
  String? message;
  int? extraData;
  List<PropertyData>? data;

  PropertyResponse({this.status, this.message, this.extraData, this.data});

  PropertyResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    extraData = json['extraData'];
    if (json['data'] != null) {
      data = <PropertyData>[];
      json['data'].forEach((v) {
        data!.add(new PropertyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['extraData'] = this.extraData;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PropertyData {
  String? sId;
  String? userId;
  String? propertyType;
  String? propertyServiceType;
  List<String>? amenities;
  int? bedroomsCount;
  int? bathroomsCount;
  String? propertyStatus;
  String? listedBy;
  int? internalArea;
  int? externalArea;
  String? floorLevel;
  String? facing;
  String? title;
  String? description;
  List<MediaUrl>? mediaUrl;
  int? price;
  List<NearbyFacilities>? nearbyFacilities;
  String? priceType;
  String? priceNegotiable;
  PropertyLocation? propertyLocation;
  String? propertyLocationName;
  double? propertyLattitude;
  double? propertyLongitude;
  List<Address>? address;
  bool? disablePropery;
  int? iV;
  UserData? userData;

  PropertyData(
      {this.sId,
        this.userId,
        this.propertyType,
        this.propertyServiceType,
        this.amenities,
        this.bedroomsCount,
        this.bathroomsCount,
        this.propertyStatus,
        this.listedBy,
        this.internalArea,
        this.externalArea,
        this.floorLevel,
        this.facing,
        this.title,
        this.description,
        this.mediaUrl,
        this.price,
        this.nearbyFacilities,
        this.priceType,
        this.priceNegotiable,
        this.propertyLocation,
        this.propertyLocationName,
        this.propertyLattitude,
        this.propertyLongitude,
        this.address,
        this.disablePropery,
        this.iV,
        this.userData});

  PropertyData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    propertyType = json['property_type'];
    propertyServiceType = json['property_service_type'];
    amenities = json['amenities'].cast<String>();
    bedroomsCount = json['bedrooms_count'];
    bathroomsCount = json['bathrooms_count'];
    propertyStatus = json['property_status'];
    listedBy = json['listed_by'];
    internalArea = json['internal_area'];
    externalArea = json['external_area'];
    floorLevel = json['floor_level'];
    facing = json['facing'];
    title = json['title'];
    description = json['description'];
    if (json['media_url'] != null) {
      mediaUrl = <MediaUrl>[];
      json['media_url'].forEach((v) {
        mediaUrl!.add(new MediaUrl.fromJson(v));
      });
    }
    price = json['price'];
    if (json['nearby_facilities'] != null) {
      nearbyFacilities = <NearbyFacilities>[];
      json['nearby_facilities'].forEach((v) {
        nearbyFacilities!.add(new NearbyFacilities.fromJson(v));
      });
    }
    priceType = json['price_type'];
    priceNegotiable = json['price_negotiable'];
    propertyLocation = json['property_location'] != null
        ? new PropertyLocation.fromJson(json['property_location'])
        : null;
    propertyLocationName = json['property_location_name'];
    propertyLattitude = json['property_lattitude'];
    propertyLongitude = json['property_longitude'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
    disablePropery = json['disable_propery'];
    iV = json['__v'];
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['property_type'] = this.propertyType;
    data['property_service_type'] = this.propertyServiceType;
    data['amenities'] = this.amenities;
    data['bedrooms_count'] = this.bedroomsCount;
    data['bathrooms_count'] = this.bathroomsCount;
    data['property_status'] = this.propertyStatus;
    data['listed_by'] = this.listedBy;
    data['internal_area'] = this.internalArea;
    data['external_area'] = this.externalArea;
    data['floor_level'] = this.floorLevel;
    data['facing'] = this.facing;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.mediaUrl != null) {
      data['media_url'] = this.mediaUrl!.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    if (this.nearbyFacilities != null) {
      data['nearby_facilities'] =
          this.nearbyFacilities!.map((v) => v.toJson()).toList();
    }
    data['price_type'] = this.priceType;
    data['price_negotiable'] = this.priceNegotiable;
    if (this.propertyLocation != null) {
      data['property_location'] = this.propertyLocation!.toJson();
    }
    data['property_location_name'] = this.propertyLocationName;
    data['property_lattitude'] = this.propertyLattitude;
    data['property_longitude'] = this.propertyLongitude;
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    data['disable_propery'] = this.disablePropery;
    data['__v'] = this.iV;
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    return data;
  }
}

class MediaUrl {
  String? name;
  int? type;
  String? sId;

  MediaUrl({this.name, this.type, this.sId});

  MediaUrl.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['_id'] = this.sId;
    return data;
  }
}

class NearbyFacilities {
  String? name;
  double? distance;
  String? sId;

  NearbyFacilities({this.name, this.distance, this.sId});

  NearbyFacilities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    distance = json['distance'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['_id'] = this.sId;
    return data;
  }
}

class PropertyLocation {
  String? type;
  List<double>? coordinates;

  PropertyLocation({this.type, this.coordinates});

  PropertyLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Address {
  String? buildingName;
  int? doorNo;
  String? streetName;
  String? town;
  String? state;
  String? country;
  String? pinCode;
  String? sId;

  Address(
      {this.buildingName,
        this.doorNo,
        this.streetName,
        this.town,
        this.state,
        this.country,
        this.pinCode,
        this.sId});

  Address.fromJson(Map<String, dynamic> json) {
    buildingName = json['building_name'];
    doorNo = json['door_no'];
    streetName = json['street_name'];
    town = json['town'];
    state = json['state'];
    country = json['country'];
    pinCode = json['pin_code'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building_name'] = this.buildingName;
    data['door_no'] = this.doorNo;
    data['street_name'] = this.streetName;
    data['town'] = this.town;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pin_code'] = this.pinCode;
    data['_id'] = this.sId;
    return data;
  }
}

class UserData {
  String? sId;
  String? name;
  String? email;
  int? phoneNumber;
  String? countryCode;
  int? dob;
  String? gender;
  int? userType;
  String? profilePicture;
  List<String>? idCardImage;
  List<String>? passportImage;
  String? town;
  bool? isphoneVerified;
  bool? isActive;
  bool? createdByAdmin;
  bool? deletedByAdmin;
  bool? isDocumentUploaded;
  bool? isDocumentVerified;
  bool? blockedByAdmin;
  int? subscriptionStatus;
  int? subscriptionType;
  int? isProfileCompleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserData(
      {this.sId,
        this.name,
        this.email,
        this.phoneNumber,
        this.countryCode,
        this.dob,
        this.gender,
        this.userType,
        this.profilePicture,
        this.idCardImage,
        this.passportImage,
        this.town,
        this.isphoneVerified,
        this.isActive,
        this.createdByAdmin,
        this.deletedByAdmin,
        this.isDocumentUploaded,
        this.isDocumentVerified,
        this.blockedByAdmin,
        this.subscriptionStatus,
        this.subscriptionType,
        this.isProfileCompleted,
        this.createdAt,
        this.updatedAt,
        this.iV});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
    dob = json['dob'];
    gender = json['gender'];
    userType = json['user_type'];
    profilePicture = json['profile_picture'];
    idCardImage = json['id_card_image'].cast<String>();
    passportImage = json['passport_image'].cast<String>();
    town = json['town'];
    isphoneVerified = json['isphone_verified'];
    isActive = json['is_Active'];
    createdByAdmin = json['created_By_Admin'];
    deletedByAdmin = json['deleted_By_Admin'];
    isDocumentUploaded = json['is_document_uploaded'];
    isDocumentVerified = json['is_document_verified'];
    blockedByAdmin = json['blocked_by_admin'];
    subscriptionStatus = json['subscriptionStatus'];
    subscriptionType = json['subscriptionType'];
    isProfileCompleted = json['is_profile_completed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['country_code'] = this.countryCode;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['user_type'] = this.userType;
    data['profile_picture'] = this.profilePicture;
    data['id_card_image'] = this.idCardImage;
    data['passport_image'] = this.passportImage;
    data['town'] = this.town;
    data['isphone_verified'] = this.isphoneVerified;
    data['is_Active'] = this.isActive;
    data['created_By_Admin'] = this.createdByAdmin;
    data['deleted_By_Admin'] = this.deletedByAdmin;
    data['is_document_uploaded'] = this.isDocumentUploaded;
    data['is_document_verified'] = this.isDocumentVerified;
    data['blocked_by_admin'] = this.blockedByAdmin;
    data['subscriptionStatus'] = this.subscriptionStatus;
    data['subscriptionType'] = this.subscriptionType;
    data['is_profile_completed'] = this.isProfileCompleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}