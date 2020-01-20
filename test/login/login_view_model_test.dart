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
import 'package:flutter_cac/login/login_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mock_repository.dart';

void main() {
  test('should return false when userName is invalid', () {
    // Given
    final repository = MockRepository();
    when(repository.isLogin()).thenAnswer((_) => Future.value(false));

    final viewModel = LoginViewModel(repository);

    bool isValid = false;

    viewModel.addListener(() {
      isValid = viewModel.isValid;
    });
    // When
    viewModel.checkUserName("");
    viewModel.checkPassword("123456789");
    // Then
    expect(isValid, false);
  });

  test('should return false when password is invalid', () {
    // Given
    final repository = MockRepository();
    when(repository.isLogin()).thenAnswer((_) => Future.value(false));

    final viewModel = LoginViewModel(repository);

    bool isValid = false;

    viewModel.addListener(() {
      isValid = viewModel.isValid;
    });
    // When
    viewModel.checkUserName("komamj");
    viewModel.checkPassword("");
    // Then
    expect(isValid, false);
  });

  test('should return true when userName is valid and password is valid', () {
    // Given
    final repository = MockRepository();
    when(repository.isLogin()).thenAnswer((_) => Future.value(false));

    final viewModel = LoginViewModel(repository);

    bool isValid = false;

    viewModel.addListener(() {
      isValid = viewModel.isValid;
    });
    // When
    viewModel.checkUserName("komamj");
    viewModel.checkPassword("123456789");
    // Then
    expect(isValid, true);
  });
}
