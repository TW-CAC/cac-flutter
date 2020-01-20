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

import 'package:flutter_cac/data/entities/course.dart';
import 'package:flutter_cac/data/entities/homework.dart';
import 'package:flutter_cac/data/entities/user.dart';
import 'package:flutter_cac/data/source/local/local_data_source_imp.dart';
import 'package:flutter_cac/data/source/remote/remote_data_source.dart';
import 'package:flutter_cac/data/source/repository.dart';

import 'local/local_data_source.dart';

class RepositoryImp extends Repository {
  RemoteDataSource _remoteDataSource = RemoteDataSource.singleton;
  LocalDataSource _localDataSource = LocalDataSourceImp.singleton;

  static final Repository singleton = RepositoryImp.internal();

  factory RepositoryImp() {
    return singleton;
  }

  RepositoryImp.internal();

  @override
  Future<List<Course>> getCourses() {
    return _remoteDataSource.getCourses();
  }

  @override
  Future<List<Homework>> getRemoteHomework() async {
    return null;
  }

  @override
  Future<Homework> getDraftHomework() {
    return _localDataSource.getDraftHomework();
  }

  @override
  Future<bool> postHomework(Homework homework) {
    _localDataSource.clearHomework();
    return _remoteDataSource.postHomework(homework);
  }

  @override
  Future<bool> saveHomework(Homework homework) {
    return _localDataSource.saveHomework(homework);
  }

  @override
  Future<bool> isDarkMode() {
    return _localDataSource.isDarkMode();
  }

  @override
  Future<bool> switchThemeMode() {
    return _localDataSource.switchThemeMode();
  }

  @override
  Future<bool> isLogin() {
    return _localDataSource.isLogin();
  }

  @override
  Future<User> login(String userName, String password) async {
    User user = await _remoteDataSource.login(userName, password);
    if (user != null) {
      await _localDataSource.persistenceLoginUser(user);
    }
    return user;
  }

  @override
  Future<User> register(String userName, String password) {
    return _remoteDataSource.register(userName, password);
  }

  @override
  Future<bool> logout() {
    return _localDataSource.logout();
  }

  @override
  Future<User> getLoginUser() async {
    bool _isLogin = await isLogin();
    if (_isLogin) {
      return _localDataSource.getLoginUser();
    }
    return null;
  }
}
