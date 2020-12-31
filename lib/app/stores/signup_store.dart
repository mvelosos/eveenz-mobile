import 'package:mobx/mobx.dart';
part 'signup_store.g.dart';

class SignUpStore = _SignUpStoreBase with _$SignUpStore;

abstract class _SignUpStoreBase with Store {
  @observable
  bool loading = false;

  @action
  void setLoading(bool value) {
    loading = value;
  }
}
