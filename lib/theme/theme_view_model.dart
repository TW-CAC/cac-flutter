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
import 'package:flutter_cac/data/source/repository.dart';

class ThemeViewModel extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  Repository _repository;

  ThemeViewModel(Repository repository) {
    _repository = repository;

    _repository.isDarkMode().then((isDarkMode) {
      _isDarkMode = isDarkMode;
      print("theme mode is dark:$_isDarkMode");
    });
  }

  void switchTheme() {
    _repository.switchThemeMode();
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
