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
import 'package:flutter_cac/data/entities/course.dart';
import 'package:flutter_cac/login/login_view_model.dart';
import 'package:provider/provider.dart';

import 'course_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Strings.home),
      ),
      body: RefreshIndicator(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 100,
          itemBuilder: (BuildContext context, int position) {
            if (position % 2 == 0) {
              return CourseItem(
                onTap: _onTap,
                onPressed: _onPressed,
                course: Course(
                    title: "Oppo管理特种兵第二期",
                    creatorName: "宇宙",
                    subscribeCount: 20),
              );
            } else {
              return CourseItem(
                onTap: _onTap,
                onPressed: _onPressed,
                course: Course(
                    title: "Oppo技术特种兵第一期",
                    creatorName: "覃老板",
                    subscribeCount: 19),
              );
            }
          },
        ),
        onRefresh: _onRefresh,
      ),
    );
  }

  Future<Null> _onRefresh() async {
    await Future.delayed(
      Duration(milliseconds: 1500),
    );
    return null;
  }

  void _onPressed() {
    LoginViewModel viewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    if (viewModel.isLogin) {
      // todo subscribe course
    } else {
      Navigator.pushNamed(context, Routes.login);
    }
  }

  void _onTap() {
    Navigator.pushNamed(context, Routes.classDetail);
  }
}
