import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/ui/scene/login/redux/login_actions.dart';
import 'package:time_tracker/app/ui/scene/login/redux/login_state.dart';
import 'package:time_tracker/redux/redux.dart';

class LoginForm extends StatefulWidget {
  LoginForm();

  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _urlField = GlobalKey<FormFieldState>();
  final _loginFieldKey = GlobalKey<FormFieldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState>();

  final apiUrlTextController = TextEditingController();
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiUrlTextController.text = "https://r.webant.ru";
  }

  @override
  void dispose() {
    apiUrlTextController.dispose();
    loginTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Store<LoginState>>(
      builder: (context, store, _) {
        var state = store.state;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              enabled: !state.isLoading,
              key: _urlField,
              controller: apiUrlTextController,
              validator: (value) => value.isEmpty ? "Fill api url" : null,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Api url",
              ),
            ),
            TextFormField(
              enabled: !state.isLoading,
              key: _loginFieldKey,
              controller: loginTextController,
              validator: (value) => value.isEmpty ? "Fill login" : null,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Login",
              ),
            ),
            TextFormField(
              obscureText: true,
              enabled: !state.isLoading,
              key: _passwordFieldKey,
              controller: passwordTextController,
              validator: (value) => value.isEmpty ? "Fill password" : null,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Password",
                errorText: state.loginErrorMessage,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: state.isLoading
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      onPressed: () {
                        if (_urlField.currentState.validate() &&
                            _loginFieldKey.currentState.validate() &&
                            _passwordFieldKey.currentState.validate()) {
                          store.dispatch(
                            DoLoginAction(
                              apiURL: _urlField.currentState.value,
                              login: _loginFieldKey.currentState.value,
                              password: _passwordFieldKey.currentState.value,
                            ),
                          );
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text("Log in"),
                    ),
            )
          ],
        );
      },
    );
  }
}
