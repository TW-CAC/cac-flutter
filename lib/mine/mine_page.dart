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

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Strings.mine),
      ),
      body: new Column(children: <Widget>[
        new Row(
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              child: new CircleAvatar(
                child: new Text("Allen"),
              ),
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(top: 20, left: 10),
                    child: new Text("15019011123",
                        style: Theme.of(context).textTheme.subhead),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0, left: 10),
                    child: new Text("CAC技术教练"),
                  )
                ],
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(right: 20, top: 20),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    "退出",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 24),
                  ),
                  onPressed: () => Navigator.pushNamed(context, Routes.login),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
