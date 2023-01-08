
import 'package:renteadmin/model/user_response.dart';

import '../../model/success_response.dart';
import '../../untils/rest_ds.dart';

abstract class ViewUserInterface {
  onUserSuccess(UserResponse user);
  onBlockUserSuccess(SuccessResponse user);
  onVerifyUnverifySuccess(SuccessResponse user);
  onError(int errorCode);
}

class ViewUserPresenter {
  ViewUserInterface _view;
  RestDatasource api = new RestDatasource();

  ViewUserPresenter(this._view);

  doUserListAPI(String user_type,int pageNumber) {
    api.getUserSellerData(user_type,pageNumber)
        .then((UserResponse user) {
      if (user.status! == 200) {
        _view.onUserSuccess(user);
      }else if(user.status! == 400)
        {
          _view.onError(user.status!);
        }
      else {
        _view.onError(user.status!);
      }
    }).catchError((Object error) => _view.onError(400));
  }


  doUserBlockAPI(String user_id,String status) {
    api.postBlockUser(user_id, status)
        .then((SuccessResponse user) {
      if (user.status! == 200) {
        _view.onBlockUserSuccess(user);
      }else if(user.status! == 400)
      {
        _view.onError(user.status!);
      }
      else {
        _view.onError(user.status!);
      }
    }).catchError((Object error) => _view.onError(400));
  }
  doVerifyUnverifyAPI(String user_id,String status) {
    api.onVerifyUnverify(user_id, status)
        .then((SuccessResponse user) {
      if (user.status! == 200) {
        _view.onVerifyUnverifySuccess(user);
      }else if(user.status! == 400)
      {
        _view.onError(user.status!);
      }
      else {
        _view.onError(user.status!);
      }
    }).catchError((Object error) => _view.onError(400));
  }


//End
}
