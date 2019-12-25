import 'package:flutter/material.dart';
import 'package:flutter_cac/common/strings.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Strings.home),
      ),
    );
  }
}
