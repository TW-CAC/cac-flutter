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
import 'package:flutter_cac/data/entities/user.dart';
import 'package:flutter_cac/login/login_view_model.dart';
import 'package:flutter_cac/widget/expansion_button.dart';
import 'package:flutter_cac/widget/loading.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        title: Text("注册"),
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
            Consumer<LoginViewModel>(
              builder: (context, viewModel, child) {
                return ExpansionButton(
                  label: "注册并登录",
                  onPressed: viewModel.isValid ? _onLoginPressed : null,
                );
              },
            ),
          ],
        ),
      ),
    );
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
        content: "注册中，请稍候...",
      ),
    );

    LoginViewModel viewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    User result = await viewModel.register(
        _userNameController.text, _passwordController.text);
    Navigator.of(context).pop();
    if (result != null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("注册成功"),
        duration: Duration(milliseconds: 1000),
      ));

      Future.delayed(
        Duration(milliseconds: 1000),
      ).whenComplete(() {
        Navigator.of(context).pop();
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("注册失败,请稍候重试。"),
        duration: Duration(milliseconds: 1000),
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
