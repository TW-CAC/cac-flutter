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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cac/data/entities/course.dart';
import 'package:flutter_cac/home/subscribe_outline_button.dart';

class CourseItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final VoidCallback onPressed;

  final Course course;

  const CourseItem(
      {Key key,
      @required this.onTap,
      @required this.onPressed,
      @required this.course})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 4,
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
        elevation: 4,
        child: Stack(
          alignment: Alignment.topRight,
          fit: StackFit.loose,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 180,
                  color: Colors.deepOrange,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Text(
                    course.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Text(
                    course.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8, bottom: 8),
                        child: Text(course.creator.name),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: 8, bottom: 8),
                        child: Text(
                          "${course.subscribers.length}人已订阅",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SubscribeOutlineButton(
              course: course,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
