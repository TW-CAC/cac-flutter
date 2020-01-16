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
import 'package:flutter_cac/data/source/remote/web_service.dart';

class RemoteDataSource implements WebService {
  static final RemoteDataSource singleton = RemoteDataSource.internal();

  factory RemoteDataSource() {
    return singleton;
  }

  RemoteDataSource.internal();

  @override
  getCourses() {
    // TODO: implement getCourses
    return null;
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
