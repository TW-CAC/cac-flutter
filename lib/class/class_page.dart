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
import 'package:flutter_cac/common/strings.dart';
import 'package:flutter_cac/login/login_view_model.dart';
import 'package:provider/provider.dart';

class ClassPage extends StatefulWidget {
  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("班级详情"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.white,
            ),
            onPressed: _onUpload,
          )
        ],
      ),
      body: Column(
        children: <Widget>[],
      ),
      floatingActionButton: _buildFloatActionButton(),
    );
  }

  void _onUpload() {}

  FloatingActionButton _buildFloatActionButton() {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text(Strings.homework),
      onPressed: () {
        _showHomeworkPage();
      },
    );
  }

  void _showHomeworkPage() async {
    LoginViewModel viewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    bool result = await viewModel.isLogin();
    if (result) {
      Navigator.pushNamed(context, Routes.homework);
    } else {
      Navigator.pushNamed(context, Routes.login);
    }
  }
}
