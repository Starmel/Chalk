import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/ui/scene/login/login_form.dart';
import 'package:time_tracker/app/ui/scene/login/redux/login_router.dart';
import 'package:time_tracker/app/ui/scene/login/redux/login_state.dart';
import 'package:time_tracker/redux/redux.dart';

class LoginScene extends StatefulWidget {
  static const navigationKey = "LoginScene";

  final _store = Store(
    initialState: LoginState.initial(),
    middlewares: [
      LoginRouterMiddleWare(),
    ],
  );

  @override
  _LoginSceneState createState() => _LoginSceneState(_store);
}

class _LoginSceneState extends State<LoginScene> {
  final Store<LoginState> _store;

  _LoginSceneState(this._store);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Chalk"),
          leading: Image.asset("resources/drawable/chalk-logo-wobg.png"),
        ),
        body: Container(
          padding: EdgeInsets.only(right: 40, left: 40),
          child: Center(
            child: ChangeNotifierProvider(
              builder: (_) => _store,
              child: LoginForm(),
            ),
          ),
        ),
      );
}
