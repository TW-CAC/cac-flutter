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
import 'package:flutter_cac/data/entities/homework.dart';
import 'package:flutter_cac/homework/homework_view_model.dart';
import 'package:provider/provider.dart';

class HomeworkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeworkState();
  }
}

class _HomeworkState extends State<HomeworkPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  Homework _homework;

  @override
  void initState() {
    super.initState();

    debugPrint("_HomeworkState initState");

    Provider.of<HomeworkViewModel>(context, listen: false)
        .getDraftHomework()
        .then((result) {
      _homework = result;
      debugPrint("_homework:${_homework.toString()}");
      if (_homework != null) {
        _titleController.text = _homework.title;
        _contentController.text = _homework.content;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("发布作业"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            tooltip: "保存至草稿",
            icon: Icon(Icons.save),
            onPressed: _saveHomeHomework,
          ),
          IconButton(
            tooltip: "发布",
            icon: Icon(Icons.send),
            onPressed: _postHomework,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text("标题"),
            ),
            TextField(
              autofocus: false,
              maxLength: 100,
              maxLines: 1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '请输入作业的标题',
              ),
              controller: _titleController,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text("内容"),
            ),
            Expanded(
              child: Container(
                child: TextField(
                  autofocus: false,
                  maxLength: 1000,
                  maxLines: 50,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '请输入作业的详细内容',
                  ),
                  controller: _contentController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();

    super.dispose();
  }

  void _postHomework() {
    Provider.of<HomeworkViewModel>(context, listen: false)
        .postHomework(_titleController.text, _contentController.text)
        .then((result) {
      _showSnackBar(result);
    }).catchError((error) {
      _showSnackBar(error.toString());
    });
  }

  void _saveHomeHomework() {
    Provider.of<HomeworkViewModel>(context, listen: false)
        .saveHomework(_titleController.text, _contentController.text)
        .then((result) {
      _showSnackBar(result);
    }).catchError((error) {
      _showSnackBar(error.toString());
    });
  }

  void _showSnackBar(String content) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
