
import '../../model/success_response.dart';
import '../../untils/rest_ds.dart';

abstract class ChangePasswordInterface {
  onSuccess(SuccessResponse user);
  onError(String msg,int errorCode);
}

class ChangePasswordPresenter {
  ChangePasswordInterface _view;
  RestDatasource api = new RestDatasource();

  ChangePasswordPresenter(this._view);


  doChangePWD(String old_password,String new_password) {
    api.changePassword(old_password, new_password)
        .then((SuccessResponse user) {
      if (user.status == 200) {
        _view.onSuccess(user);
      }else if(user.status == 400)
        {
          _view.onError(user.message!,user.status!);
        }
      else {
        _view.onError(user.message!,user.status!);
      }
    }).catchError((Object error) => _view.onError(error.toString(),400));
  }
}
