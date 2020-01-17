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

import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cac/common/preferences_key.dart';
import 'package:flutter_cac/data/entities/course.dart';
import 'package:flutter_cac/data/entities/homework.dart';
import 'package:flutter_cac/data/entities/user.dart';
import 'package:flutter_cac/data/source/remote/web_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteDataSource implements WebService {
  static const String baseUrl = "http://localhost:8081/api/";

  static final RemoteDataSource singleton = RemoteDataSource.internal();

  Dio _client;

  factory RemoteDataSource() {
    return singleton;
  }

  RemoteDataSource.internal() {
    _client = Dio();
    _client.options.baseUrl = baseUrl;
    _client.options.receiveTimeout = 1000 * 10; //10秒
    _client.options.connectTimeout = 1000 * 10; //10秒
    (_client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    _client.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    _initHeaders();
  }

  void _initHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString(PreferencesKey.keyAccessToken);
    if (accessToken != null && accessToken.isNotEmpty) {
      _client.options.headers = {"Authorization": "$accessToken"};
    }
  }

  @override
  Future<User> login(String userName, String password) async {
    FormData formData =
        FormData.fromMap({"username": userName, "password": password});
    Response response = await _client.post(
      "rest/auth/user/login",
      data: formData,
    );
    if (response.statusCode == HttpStatus.ok) {}
    return null;
  }

  @override
  Future<User> register(String userName, String password) async {
    FormData formData =
        FormData.fromMap({"username": userName, "password": password});
    Response response = await _client.post(
      "rest/auth/user/register",
      data: formData,
    );
    if (response.statusCode == HttpStatus.ok) {}
    return null;
  }

  @override
  Future<List<Course>> getCourses() async {
    /*Response response = await _client.get("course");
    if (response.statusCode == HttpStatus.ok) {}*/
    var questions = [
      "《敏捷教练培养的“守、破、离”》读后感​",
      "《培养“教练团队”为什么是敏捷转型中的必经之路》读后感",
      "文化轰炸",
      "站会总有人迟到怎么破？",
      "文化解读之“求责于己”实例化",
      "结合实践案例分享需求梳理过程中遇到的困难和解决方案",
      "《Scrum看板相得益彰》读书笔记",
      "《Scrum精髓》读书笔记",
      "深度思考：如何提高质量",
      "AC验收条件作业分享",
      "《如何构建敏捷项目管理团队》读书笔记",
      "关于“度量”",
      "STAR模型"
    ];
    var courses = List.generate(20, (index) {
      return Course(
        id: index.toString(),
        title: "CAC管理教练特种兵计划",
        description: "CAC管理教练特种兵计划日常作业",
        questions: questions,
        creatorName: index % 2 == 0 ? "宇宙" : "覃宇",
        subscribeIds: ["1", "2", "3"],
      );
    });
    await Future.delayed(
      Duration(milliseconds: 2),
    );
    return courses;
  }

  @override
  getPopularCourses() {
    return null;
  }

  @override
  getTopRatedCourses() {
    return null;
  }

  @override
  postCourse() {
    return null;
  }

  @override
  Future<bool> postHomework(Homework homework) async {
    return Future.delayed(Duration(milliseconds: 5000), () {
      return true;
    });
  }
}
