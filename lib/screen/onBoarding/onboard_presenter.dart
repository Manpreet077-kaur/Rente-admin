import 'package:renteadmin/model/property_response.dart';

import '../../model/onBoarding_response.dart';
import '../../model/success_response.dart';
import '../../untils/rest_ds.dart';
abstract class OnboardInterface {
  onOnboardSuccess(OnboardingResponse user);
  onAddCategorySuccess(SuccessResponse user);
  onError(String msg);
}

class OnboardPresenter {
  OnboardInterface _view;
  RestDatasource api = new RestDatasource();

  OnboardPresenter(this._view);

  doOnBoardingList() {
    api.getOnBoardingList()
        .then((OnboardingResponse user) {
      if (user.status! == 200) {
        _view.onOnboardSuccess(user);
      } else if (user.status! == 400) {
        _view.onError(user.message!);
      }
      else {
        _view.onError(user.message!);
      }
    }).catchError((Object error) => _view.onError("Error"));
  }

  doEditCategory(String category_id,String category_name, List<int> category_image,String status) {
    api.editCategory(category_id,category_name, category_image,status)
        .then((SuccessResponse user) {
      if (user.status == 200) {
        _view.onAddCategorySuccess(user);
      } else if (user.status == 400) {
        _view.onError(user.message!);
      }
      else {
        _view.onError(user.message!);
      }
    }).catchError((Object error) => _view.onError(error.toString()));
  }
}


