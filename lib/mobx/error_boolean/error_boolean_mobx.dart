import 'package:mobx/mobx.dart';

part 'error_boolean_mobx.g.dart';

class ErrorBoolean = ErrorBooleanBase with _$ErrorBoolean;

abstract class ErrorBooleanBase with Store {
  @observable
  bool error = false;

  @action
  setError(bool value) => error = value;
}
