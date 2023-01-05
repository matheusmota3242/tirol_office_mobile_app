// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_boolean_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ErrorBoolean on ErrorBooleanBase, Store {
  late final _$errorAtom =
      Atom(name: 'ErrorBooleanBase.error', context: context);

  @override
  bool get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(bool value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$ErrorBooleanBaseActionController =
      ActionController(name: 'ErrorBooleanBase', context: context);

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$ErrorBooleanBaseActionController.startAction(
        name: 'ErrorBooleanBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$ErrorBooleanBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error}
    ''';
  }
}
