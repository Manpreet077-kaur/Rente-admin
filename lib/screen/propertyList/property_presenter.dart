import 'package:renteadmin/model/property_response.dart';
import '../../untils/rest_ds.dart';
abstract class PropertyInterface {
  onPropertySuccess(PropertyResponse user);
  onError(String msg);
}

class PropertyPresenter {
  PropertyInterface _view;
  RestDatasource api = new RestDatasource();

  PropertyPresenter(this._view);

  doPropertyList() {
    api.getPropertyList()
        .then((PropertyResponse user) {
      if (user.status! == 200) {
        _view.onPropertySuccess(user);
      } else if (user.status! == 400) {
        _view.onError(user.message!);
      }
      else {
        _view.onError(user.message!);
      }
    }).catchError((Object error) => _view.onError("Error"));
  }
}

