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

import 'package:flutter_cac/data/entities/homework.dart';
import 'package:flutter_cac/data/entities/user.dart';

abstract class LocalDataSource {
  Future<bool> saveHomework(Homework homework);

  Future<bool> clearHomework();

  Future<Homework> getDraftHomework();

  Future<bool> isDarkMode();

  Future<bool> switchThemeMode();

  Future<User> getLoginUser();

  Future<bool> persistenceLoginUser(User user);

  Future<bool> isLogin();

  Future<bool> logout();
}
