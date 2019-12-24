import 'package:flutter/material.dart';

import 'splash/splash_page.dart';

void main() => runApp(CACAPP());

class CACAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAC',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashPage(),
    );
  }
}
