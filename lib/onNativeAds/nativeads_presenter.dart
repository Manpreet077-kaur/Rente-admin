import 'package:renteadmin/model/property_response.dart';

import '../../model/onBoarding_response.dart';
import '../../model/success_response.dart';
import '../../untils/rest_ds.dart';
import '../model/advertise_response.dart';

abstract class NativeAdsInterface {
  onNativeAdsListSuccess(AdvertisementResponse user);
  onAddNativeAdsSuccess(SuccessResponse user);
  onAdsDisableSuccess(SuccessResponse user);
  onEditAdsSuccess(SuccessResponse user);
  onError(String msg);
}

class NativeAdsPresenter {
  NativeAdsInterface _view;
  RestDatasource api = new RestDatasource();

  NativeAdsPresenter(this._view);

  doOnBoardingList() {
    api.getNativeAdsList()
        .then((AdvertisementResponse user) {
      if (user.status! == 200) {
        _view.onNativeAdsListSuccess(user);
      } else if (user.status! == 400) {
        _view.onError(user.message!);
      }
      else {
        _view.onError(user.message!);
      }
    }).catchError((Object error) => _view.onError("Error"));
  }

  doAdsDisablePost(String ad_id,String ad_status) {
    api.disableAdsPost(ad_id,ad_status)
        .then((SuccessResponse user) {
      if (user.status! == 200) {
        _view.onAdsDisableSuccess(user);
      } else if (user.status! == 400) {
        _view.onError(user.message!);
      }
      else {
        _view.onError(user.message!);
      }
    }).catchError((Object error) => _view.onError("Error"));
  }

  doAddNativeAds(String nativeads_name, var nativeads_image,String url,String filePath) {

    api.adsNativePost(nativeads_name, nativeads_image,url,filePath)
        .then((SuccessResponse user) {
      if (user.status == 200) {
        _view.onAddNativeAdsSuccess(user);
      } else if (user.status == 400) {
        _view.onError(user.message!);
      }
      else {
        _view.onError(user.message!);
      }
    }).catchError((Object error) => _view.onError(error.toString()));
  }
  doEditAds(String ads_id,String ads_name, List<int> ads_image,String ads_url) {
    api.editAds(ads_id,ads_name, ads_image,ads_url)
        .then((SuccessResponse user) {
      if (user.status == 200) {
        _view.onEditAdsSuccess(user);
      } else if (user.status == 400) {
        _view.onError(user.message!);
      }
      else {
        _view.onError(user.message!);
      }
    }).catchError((Object error) => _view.onError(error.toString()));
  }

}


