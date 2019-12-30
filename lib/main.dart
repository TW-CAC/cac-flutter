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
import 'package:flutter_cac/data/source/repository_imp.dart';
import 'package:flutter_cac/homework/homework_page.dart';
import 'package:flutter_cac/homework/homework_view_model.dart';
import 'package:flutter_cac/login/login_page.dart';
import 'package:flutter_cac/login/login_view_model.dart';
import 'package:flutter_cac/main/main_page.dart';
import 'package:flutter_cac/mine/mine_page.dart';
import 'package:flutter_cac/theme/theme_view_model.dart';
import 'package:provider/provider.dart';

import 'splash/splash_page.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeViewModel(RepositoryImp.singleton),
          ),
          ChangeNotifierProvider(
            create: (_) => LoginViewModel(RepositoryImp.singleton),
          ),
          ChangeNotifierProvider(
            create: (_) => HomeworkViewModel(RepositoryImp.singleton),
          ),
        ],
        child: CACAPP(),
      ),
    );

class CACAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CAC',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: SplashPage(),
      routes: {
        Routes.main: (_) => MainPage(),
        Routes.mine: (_) => MinePage(),
        Routes.assignment: (_) => AssignmentPage(),
        Routes.cart: (_) => ShoppingCartPage(),
        Routes.login: (_) => LoginPage(),
        Routes.homework: (_) => HomeworkPage(),
      },
    );
  }
}
