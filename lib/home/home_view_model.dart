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

import 'package:flutter_cac/common/view_model.dart';
import 'package:flutter_cac/data/entities/course.dart';
import 'package:flutter_cac/data/source/repository.dart';

class HomeViewModel extends ViewModel {
  var _courses = List<Course>();

  List<Course> get courses => _courses;

  bool _isSubscribed = false;

  bool get isSubscribed => _isSubscribed;

  HomeViewModel(Repository repository) : super(repository: repository);

  Future<Null> refresh() async {
    var result = await repository.getCourses();
    _courses.clear();
    _courses.addAll(result);
    notifyListeners();
    return null;
  }

  void subscribe(Course course) {
    course.isSubscribed = true;
    notifyListeners();
    // todo 订阅课程
  }
}
