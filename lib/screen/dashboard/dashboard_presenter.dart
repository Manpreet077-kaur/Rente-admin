
import 'package:renteadmin/model/dashboard_response.dart';
import '../../untils/rest_ds.dart';

abstract class DashBoardInterface {
  onSuccess(DashboardResponse user);
  onError(String msg,int errorCode);
}

class DashBoardPresenter {
  DashBoardInterface _view;
  RestDatasource api = new RestDatasource();

  DashBoardPresenter(this._view);


  doDashBoard() {
    api.getDashboardData()
        .then((DashboardResponse user) {
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
