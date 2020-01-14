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
import 'package:flutter_cac/login/login_button.dart';

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
                hintText: "请输入您的账号",
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
                hintText: "请输入您的密码",
                labelText: "密码",
              ),
              obscureText: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              validator: _passwordValidator,
            ),
            LoginButton(
              onPressed: _onLoginPressed,
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginPressed() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("登录成功"),
      duration: Duration(milliseconds: 1000),
    ));

    Future.delayed(
      Duration(milliseconds: 1000),
    ).whenComplete(() {
      Navigator.of(context).pop();
    });
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
