import 'package:mobx/mobx.dart';

part 'service_provider_dropdown_mobx.g.dart';

class ServiceProviderDropdown = ServiceProviderDropdownBase
    with _$ServiceProviderDropdown;

abstract class ServiceProviderDropdownBase with Store {
  @observable
  late String serviceProviderName;

  @action
  setServiceProviderName(String name) => serviceProviderName = name;

  initServiceDropdown(String name) => serviceProviderName = name;
}
