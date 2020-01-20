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

class Course {
  String id;
  String title;
  String description;
  User creator;
  List<User> subscribers;
  List<Homework> questions;

  bool isSubscribed = false;

  Course(
      {this.id,
      this.title,
      this.description,
      this.creator,
      this.subscribers,
      this.questions});

  factory Course.fromJson(Map<String, dynamic> json) {
    List<User> subscribers = (json['subscribers'] as List)
        .map((item) => User.fromJson(item))
        .toList();
    List<Homework> homework = (json['questions'] as List)
        .map((item) => Homework.fromJson(item))
        .toList();
    return Course(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        creator: User.fromJson(json['creator']),
        subscribers: subscribers,
        questions: homework);
  }
}
