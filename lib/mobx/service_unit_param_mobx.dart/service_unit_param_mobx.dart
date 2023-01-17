import 'package:mobx/mobx.dart';

part 'service_unit_param_mobx.g.dart';

class ServiceUnitParamMobx = ServiceUnitParamMobxBase
    with _$ServiceUnitParamMobx;

abstract class ServiceUnitParamMobxBase with Store {
  @observable
  String value = 'Todos';

  @action
  setValue(String newValue) => value = newValue;
}
