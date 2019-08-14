// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginState extends LoginState {
  @override
  final bool isLoading;
  @override
  final String loginErrorMessage;

  factory _$LoginState([void Function(LoginStateBuilder) updates]) =>
      (new LoginStateBuilder()..update(updates)).build();

  _$LoginState._({this.isLoading, this.loginErrorMessage}) : super._() {
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('LoginState', 'isLoading');
    }
  }

  @override
  LoginState rebuild(void Function(LoginStateBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  LoginStateBuilder toBuilder() => new LoginStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginState && isLoading == other.isLoading && loginErrorMessage == other.loginErrorMessage;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, isLoading.hashCode), loginErrorMessage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginState')
          ..add('isLoading', isLoading)
          ..add('loginErrorMessage', loginErrorMessage))
        .toString();
  }
}

class LoginStateBuilder implements Builder<LoginState, LoginStateBuilder> {
  _$LoginState _$v;

  bool _isLoading;

  bool get isLoading => _$this._isLoading;

  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  String _loginErrorMessage;

  String get loginErrorMessage => _$this._loginErrorMessage;

  set loginErrorMessage(String loginErrorMessage) => _$this._loginErrorMessage = loginErrorMessage;

  LoginStateBuilder();

  LoginStateBuilder get _$this {
    if (_$v != null) {
      _isLoading = _$v.isLoading;
      _loginErrorMessage = _$v.loginErrorMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LoginState;
  }

  @override
  void update(void Function(LoginStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginState build() {
    final _$result = _$v ?? new _$LoginState._(isLoading: isLoading, loginErrorMessage: loginErrorMessage);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
