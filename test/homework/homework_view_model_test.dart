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
import 'package:flutter_cac/homework/homework_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mock_repository.dart';

void main() {
  test(
      "should return ${"保存成功。"} when saveHomework called if data is valid and model layer save successful",
      () async {
    // Given
    final repository = MockRepository();
    when(repository.saveHomework(any)).thenAnswer((_) => Future.value(true));
    final viewModel = HomeworkViewModel(repository);
    final title = "first homework";
    final content = "I will done it!";

    // When
    String result = await viewModel.saveHomework(title, content);

    // Then
    verify(repository.saveHomework(any));
    expect(result, "保存成功。");
  });

  test(
      "should return ${"保存失败，请稍候重试。"} when saveHomework called if data is valid but model layer save failed",
      () async {
    // Given
    final repository = MockRepository();
    when(repository.saveHomework(any)).thenAnswer((_) => Future.value(false));
    final viewModel = HomeworkViewModel(repository);
    final title = "first homework";
    final content = "I will done it!";

    // When
    String result = await viewModel.saveHomework(title, content);

    // Then
    verify(repository.saveHomework(any));
    expect(result, "保存失败，请稍候重试。");
  });

  test(
      "should return ${"标题和内容不能为空"} when saveHomework called if data is invalid",
      () async {
    // Given
    final repository = MockRepository();
    final viewModel = HomeworkViewModel(repository);
    final title = "first homework";
    final content = "";

    // When
    String result = await viewModel.saveHomework(title, content);

    // Then
    verifyZeroInteractions(repository);
    expect(result, "标题和内容不能为空");
  });
}
