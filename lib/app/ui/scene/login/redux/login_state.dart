import 'package:built_value/built_value.dart';

part 'login_state.g.dart';

abstract class LoginState implements Built<LoginState, LoginStateBuilder> {
  bool get isLoading;

  @nullable
  String get loginErrorMessage;

  LoginState._();

  factory LoginState([void Function(LoginStateBuilder) updates]) = _$LoginState;

  static LoginState initial() => LoginState((b) => b..isLoading = false);
}
