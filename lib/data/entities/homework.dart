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

class Homework {
  String title;
  String content;
  String createTime;

  Homework({this.title, this.content, this.createTime});

  factory Homework.fromJson(Map<String, dynamic> json) {
    return Homework(
        title: json['title'],
        content: json['content'],
        createTime: json['create_time']);
  }

  Map<String, dynamic> toJson() =>
      {'title': title, 'content': content, 'create_time': createTime};

  @override
  String toString() {
    return toJson().toString();
  }
}
