import 'package:mobx/mobx.dart';

part 'loading_mobx.g.dart';

class LoadingMobx = LoadingMobxBase with _$LoadingMobx;

abstract class LoadingMobxBase with Store {
  @observable
  bool loading = false;

  @action
  setLoading(bool value) => loading = value;
}
