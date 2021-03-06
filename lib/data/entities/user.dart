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

class User {
  final String id;
  final String name;
  final String accessToken;

  User({this.id, this.name, this.accessToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'], name: json['userName'], accessToken: json['token']);
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'userName': name, 'token': accessToken};
}
