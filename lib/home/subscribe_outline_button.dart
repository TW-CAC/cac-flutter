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
import 'package:flutter_cac/data/entities/course.dart';

class SubscribeOutlineButton extends StatefulWidget {
  final Course course;

  final VoidCallback onPressed;

  SubscribeOutlineButton(
      {Key key, @required this.course, @required this.onPressed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SubscribeOutlineButtonState(course: course, onPressed: onPressed);
  }
}

class _SubscribeOutlineButtonState extends State<SubscribeOutlineButton> {
  final Course course;
  final VoidCallback onPressed;

  _SubscribeOutlineButtonState(
      {@required this.course, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: OutlineButton.icon(
        onPressed: onPressed,
        icon:
            Icon(course.isSubscribed ? Icons.bookmark : Icons.bookmark_border),
        label: Text(course.isSubscribed ? "已订阅" : "订阅"),
      ),
    );
  }
}
