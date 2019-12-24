import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cac/main/main_page.dart';

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
        if (_countdownTime < 0) {
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
              child: RaisedButton(
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
      text = "$text$_countdownTime";
    }
    return Text(text);
  }

  _launchMainPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => MainPage()));
  }
}
