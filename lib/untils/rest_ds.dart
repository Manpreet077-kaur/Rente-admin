import 'dart:async';
import 'package:renteadmin/model/property_response.dart';
import 'package:renteadmin/model/user_response.dart';
import 'package:renteadmin/untils/sharedpref/preferences.dart';
import 'package:renteadmin/untils/sharedpref/shared_prefrence.dart';
import '../model/advertise_response.dart';
import '../model/dashboard_response.dart';
import '../model/login_response.dart';
import '../model/onBoarding_response.dart';
import '../model/success_response.dart';
import 'network_util.dart';

class RestDatasource {
  final NetworkUtil _netUtil = new NetworkUtil();
 // static const BASE_URL = "http://rentedev-env.eba-emmvwws2.us-east-1.elasticbeanstalk.com/";
  static const BASE_URL = "http://192.168.1.87:3003/";
  static const LOGIN = BASE_URL + "admin/adminLoginWithEmailAndPassword";
  static const USER_LIST_API = BASE_URL + "admin/getSellerOrBuyerList";
  static const BLOCK_API = BASE_URL + "admin/blockOrUnblockUserByAdmin";
  static const isDocumentVerified = BASE_URL + "admin/isDocumentVerified";
  static const CHNAGE_PASSWORD = BASE_URL + "admin/changePassword";
  static const DASHBOARD_API = BASE_URL + "admin/DashboardDetails";
  static const PROPERTY_API = BASE_URL + "admin/propertyList";
  static const ONBOARDING_LIST_API = BASE_URL + "admin/onBordingDataGet";
  static const Advertisement = BASE_URL + "admin/getAllAdvertisement";
  static const EDIT_ONBOARDING = BASE_URL + "admin/onBordingDataUpdate";
  static const ADD_NATIVE_ADS = BASE_URL + "admin/addAdvertisement";
  static const changeAdStatus = BASE_URL + "admin/changeAdStatus";
  static const EDIT_ADS_URL = BASE_URL + "admin/updateAdvertisement";

  Future<LoginResponse> login(String emailId, String password) {
    return _netUtil.postApi(LOGIN, body: {
      "email": emailId,
      "password": password,
    }).then((dynamic res) {
      return LoginResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> changePassword(String oldPassword, String newPassword) {
    return _netUtil.postWithHeader(CHNAGE_PASSWORD, body: {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }


  Future<UserResponse> getUserSellerData(String user_type,int pageNumber) {
    return _netUtil.get(
      USER_LIST_API+"?user_type="+ user_type.toString()+"&pageNumber="+pageNumber.toString(),
      {
      },
    ).then((dynamic res) {
      return UserResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> postBlockUser(String user_id, String status) {
    return _netUtil.postApi(BLOCK_API, body: {
      "id": user_id,
      "status": status,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
 Future<SuccessResponse> onVerifyUnverify(String user_id, String status) {
    return _netUtil.putApiWithHeader(isDocumentVerified, body: {
      "user_id": user_id,
      "document_verified_status": status,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }
  Future<DashboardResponse> getDashboardData() {
    return _netUtil.get(
      DASHBOARD_API,
      {
      },
    ).then((dynamic res) {
      return DashboardResponse.fromJson(res);
    });
  }

  Future<PropertyResponse> getPropertyList() {
    return _netUtil.get(
      PROPERTY_API,
      {
      },
    ).then((dynamic res) {
      return PropertyResponse.fromJson(res);
    });
  }
  Future<OnboardingResponse> getOnBoardingList() {
    return _netUtil.get(
      ONBOARDING_LIST_API,
      {
      },
    ).then((dynamic res) {
      return OnboardingResponse.fromJson(res);
    });
  }
  Future<AdvertisementResponse> getNativeAdsList() {
    return _netUtil.get(
      Advertisement,
      {
      },
    ).then((dynamic res) {
      return AdvertisementResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> disableAdsPost(String ad_id,String ad_status) {
    return _netUtil.postApi(changeAdStatus, body: {
      "ad_status": ad_status,
      "ad_id": ad_id,
    }).then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> editCategory(String oboard_id,String oboard_name,
      List<int> oboard_image,String oboard_description) {
    return _netUtil.editMultipartApi(EDIT_ONBOARDING,
      {
       /* "Authorization": "b " +
            SessionManager.getString(Preferences.ACCESS_TOKEN),*/
      },
      oboard_id,
      oboard_name,
      oboard_image,
      oboard_description,
    )
        .then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }

  Future<SuccessResponse> editAds(String ads_id,String ads_name,
      List<int> ads_image,String ads_url) {
    return _netUtil.editAdsMultipartApi(EDIT_ADS_URL,
      {
        "Authorization": "b ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
      ads_id,
      ads_name,
      ads_image,
      ads_url,
    )
        .then((dynamic res) {
      return SuccessResponse.fromJson(res);
    });
  }


  Future<SuccessResponse> adsNativePost(String nativeads_name,
      var nativeads_image,String nativeads_url,String filePath) {
    return _netUtil.NativeAdsMultipartApi(ADD_NATIVE_ADS,
      {
        "Authorization": "b ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
      },
      nativeads_name,
      nativeads_image,
      nativeads_url,
      filePath
    )
        .then((dynamic res) {

      return SuccessResponse.fromJson(res);
    });
  }
}