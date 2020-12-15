import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  bool loading = false;

  @action
  void setLoading(bool value) {
    loading = value;
  }
}
