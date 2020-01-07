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
import 'package:flutter_cac/data/source/repository.dart';

class HomeworkViewModel extends ChangeNotifier {
  static const String _errorMessage = "标题和内容不能为空";

  Repository _repository;

  HomeworkViewModel(Repository repository) {
    _repository = repository;
  }

  Future<String> saveHomework(String title, String content) async {
    String resultMessage = _errorMessage;
    if (_isValid(title, content)) {
      Homework homework = _buildHomework(title, content);
      bool result = await _repository.saveHomework(homework);
      resultMessage = result ? "保存成功。" : "保存失败，请稍候重试。";
    }
    return resultMessage;
  }

  Future<Homework> getDraftHomework() async {
    Homework homework = await _repository.getDraftHomework();
    return homework;
  }

  bool _isValid(String title, String content) {
    return title.isNotEmpty && content.isNotEmpty;
  }

  Future<String> postHomework(String title, String content) async {
    String resultMessage = _errorMessage;
    if (_isValid(title, content)) {
      Homework homework = _buildHomework(title, content);
      bool result = await _repository.postHomework(homework);
      resultMessage = result ? "发布成功。" : "发布失败，请稍候重试。";
    }
    return resultMessage;
  }

  _buildHomework(String title, String content) => Homework(
      title: title,
      content: content,
      createTime: DateTime.now().toIso8601String());

  @override
  void dispose() {
    debugPrint("HomeworkViewModel dispose.");
    super.dispose();
  }
}