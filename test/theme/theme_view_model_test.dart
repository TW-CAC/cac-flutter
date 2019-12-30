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

import 'package:flutter_cac/theme/theme_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mock_repository.dart';

void main() {
  test('should return true when switchTheme called', () {
    final repository = MockRepository();
    when(repository.isDarkMode()).thenAnswer((_) => Future.value(false));
    // Given
    final viewModel = ThemeViewModel(repository);
    bool isDarkMode = false;
    viewModel.addListener(() {
      isDarkMode = viewModel.isDarkMode;
    });

    // When
    viewModel.switchTheme();

    // Then
    expect(isDarkMode, true);
  });
}
