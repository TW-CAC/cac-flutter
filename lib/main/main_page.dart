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
import 'package:flutter_cac/assignment/assignment_page.dart';
import 'package:flutter_cac/cart/shopping_cart.dart';
import 'package:flutter_cac/common/routes.dart';
import 'package:flutter_cac/common/strings.dart';
import 'package:flutter_cac/home/home_page.dart';
import 'package:flutter_cac/login/login_view_model.dart';
import 'package:flutter_cac/mine/mine_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  DateTime _lastPressed;

  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: <Widget>[
            HomePage(),
            AssignmentPage(),
            ShoppingCartPage(),
            MinePage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(Strings.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              title: Text(Strings.assignment),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text(Strings.shoppingCart),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(Strings.mine),
            ),
          ],
          onTap: _onTap,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
        floatingActionButton: _buildFloatActionButton(),
      ),
      onWillPop: _onWillPop,
    );
  }

  FloatingActionButton _buildFloatActionButton() {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text(Strings.homework),
      onPressed: () {
        _showHomeworkPage();
      },
    );
  }

  Future<bool> _onWillPop() async {
    if (_lastPressed == null ||
        DateTime.now().difference(_lastPressed) >
            Duration(milliseconds: 1500)) {
      _lastPressed = DateTime.now();
      _showSnackBar();
      return false;
    }
    return true;
  }

  void _showSnackBar() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("请再按一次确认退出应用。"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _showHomeworkPage() {
    LoginViewModel viewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    if (viewModel.isLogin) {
      Navigator.pushNamed(context, Routes.homework);
    } else {
      Navigator.pushNamed(context, Routes.login);
    }
  }

  void _onTap(int index) {
    setState(() {

//      if (index == 3) {
//        LoginViewModel viewModel =
//            Provider.of<LoginViewModel>(context, listen: false);
//        if (!viewModel.isLogin) {
//          Navigator.pushNamed(context, Routes.login);
//          return;
//        }
//      }
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
      _currentIndex = index;
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
