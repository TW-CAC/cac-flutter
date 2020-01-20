/*
 * Copyright (c) 2020. komamj
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:flutter_cac/common/routes.dart';
import 'package:flutter_cac/data/entities/user.dart';
import 'package:flutter_cac/login/login_button.dart';
import 'package:flutter_cac/widget/loading.dart';
import 'package:provider/provider.dart';

import 'login_view_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _userNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    LoginViewModel viewModel =
        Provider.of<LoginViewModel>(context, listen: false);

    _userNameController.addListener(() {
      viewModel.checkUserName(_userNameController.text);
    });
    _passwordController.addListener(() {
      viewModel.checkPassword(_passwordController.text);
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("登录"),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              width: 75.0,
              height: 75.0,
              image: AssetImage("images/ic_avatar.png"),
            ),
            TextFormField(
              maxLines: 1,
              autofocus: false,
              autovalidate: true,
              focusNode: _userNameFocusNode,
              cursorColor: Theme.of(context).accentColor,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: "账号",
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: _userNameValidator,
              controller: _userNameController,
            ),
            TextFormField(
              autofocus: false,
              maxLines: 1,
              focusNode: _passwordFocusNode,
              autovalidate: true,
              controller: _passwordController,
              cursorColor: Theme.of(context).accentColor,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                labelText: "密码",
              ),
              obscureText: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              validator: _passwordValidator,
            ),
            Consumer<LoginViewModel>(
              builder: (context, viewModel, child) {
                return LoginButton(
                  onPressed: viewModel.isValid ? _onLoginPressed : null,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: null,
                  child: Text("忘记密码？"),
                ),
                FlatButton(
                  onPressed: _onRegisterPressed,
                  child: Text("注册"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onRegisterPressed() {
    Navigator.pushNamed(context, Routes.register);
  }

  void _onLoginPressed() async {
    // 清除焦点
    _userNameFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    // 显示loading ui
    showDialog(
      context: context,
      barrierDismissible: false,
      child: Loading(
        content: "登录中，请稍候...",
      ),
    );

    LoginViewModel viewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    User result = await viewModel.login(
        _userNameController.text, _passwordController.text);

    // 取消loading ui
    Navigator.of(context).pop();

    if (result != null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("登录成功"),
        duration: Duration(milliseconds: 300),
      ));

      Future.delayed(
        Duration(milliseconds: 300),
      ).whenComplete(() {
        if (ModalRoute.of(context).isFirst &&
            ModalRoute.of(context).isCurrent &&
            ModalRoute.of(context).isActive) {
          Navigator.pushReplacementNamed(context, Routes.main);
        } else {
          Navigator.of(context).pop();
        }
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("登录失败,请稍候重试。"),
        duration: Duration(milliseconds: 300),
      ));
    }
  }

  String _passwordValidator(String v) {
    return v.trim().length > 5 || !_passwordFocusNode.hasFocus
        ? null
        : "密码不能少于6位";
  }

  String _userNameValidator(String v) {
    return v.trim().length > 0 || !_userNameFocusNode.hasFocus
        ? null
        : "用户名不能为空";
  }
}
