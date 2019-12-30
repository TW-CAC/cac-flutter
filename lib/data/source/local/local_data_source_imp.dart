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

import 'dart:convert';

import 'package:flutter_cac/common/preferences_key.dart';
import 'package:flutter_cac/data/entities/homework.dart';
import 'package:flutter_cac/data/source/local/local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSourceImp extends LocalDataSource {
  static final LocalDataSource singleton = LocalDataSourceImp.internal();

  factory LocalDataSourceImp() {
    return singleton;
  }

  LocalDataSourceImp.internal();

  @override
  Future<bool> saveHomework(Homework homework) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        PreferencesKey.keyHomework, jsonEncode(homework));
  }

  @override
  Future<bool> clearHomework() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.remove(PreferencesKey.keyHomework);
  }

  @override
  Future<Homework> getDraftHomework() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String homework = sharedPreferences.getString(PreferencesKey.keyHomework);
    return Homework.fromJson(jsonDecode(homework));
  }

  @override
  Future<bool> isDarkMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(PreferencesKey.keyDarkMode);
  }

  @override
  Future<bool> switchThemeMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isDarkMode = await LocalDataSourceImp.singleton.isDarkMode();
    return sharedPreferences.setBool(PreferencesKey.keyDarkMode, !isDarkMode);
  }
}
