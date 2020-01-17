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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cac/common/routes.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}

class _SplashState extends State<SplashPage> {
  int _countdownTime = 5;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _startCountdownTimer();
  }

  void _startCountdownTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_timer) {
      setState(() {
        if (_countdownTime <= 0) {
          _timer.cancel();

          _launchMainPage();
        } else {
          _countdownTime = _countdownTime - 1;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("images/bg_splash.png"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32, right: 16),
              child: OutlineButton(
                color: Colors.pink,
                textColor: Colors.white,
                child: _buildChildText(),
                onPressed: _launchMainPage,
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Text _buildChildText() {
    String text = "跳过";
    if (_countdownTime > 0) {
      text = "$text  $_countdownTime";
    }
    return Text(text);
  }

  _launchMainPage() {
    Navigator.pushReplacementNamed(context, Routes.main);
  }
}
