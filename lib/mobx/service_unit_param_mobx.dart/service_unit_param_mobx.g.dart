// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_unit_param_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServiceUnitParamMobx on ServiceUnitParamMobxBase, Store {
  late final _$valueAtom =
      Atom(name: 'ServiceUnitParamMobxBase.value', context: context);

  @override
  String get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(String value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$ServiceUnitParamMobxBaseActionController =
      ActionController(name: 'ServiceUnitParamMobxBase', context: context);

  @override
  dynamic setValue(String newValue) {
    final _$actionInfo = _$ServiceUnitParamMobxBaseActionController.startAction(
        name: 'ServiceUnitParamMobxBase.setValue');
    try {
      return super.setValue(newValue);
    } finally {
      _$ServiceUnitParamMobxBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
