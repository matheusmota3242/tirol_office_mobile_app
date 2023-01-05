// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_provider_dropdown_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServiceProviderDropdown on ServiceProviderDropdownBase, Store {
  late final _$serviceProviderNameAtom = Atom(
      name: 'ServiceProviderDropdownBase.serviceProviderName',
      context: context);

  @override
  String get serviceProviderName {
    _$serviceProviderNameAtom.reportRead();
    return super.serviceProviderName;
  }

  @override
  set serviceProviderName(String value) {
    _$serviceProviderNameAtom.reportWrite(value, super.serviceProviderName, () {
      super.serviceProviderName = value;
    });
  }

  late final _$ServiceProviderDropdownBaseActionController =
      ActionController(name: 'ServiceProviderDropdownBase', context: context);

  @override
  dynamic setServiceProviderName(String name) {
    final _$actionInfo =
        _$ServiceProviderDropdownBaseActionController.startAction(
            name: 'ServiceProviderDropdownBase.setServiceProviderName');
    try {
      return super.setServiceProviderName(name);
    } finally {
      _$ServiceProviderDropdownBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
serviceProviderName: ${serviceProviderName}
    ''';
  }
}
