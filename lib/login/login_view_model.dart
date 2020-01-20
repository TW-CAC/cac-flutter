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
import 'package:flutter_cac/common/view_model.dart';
import 'package:flutter_cac/data/entities/user.dart';
import 'package:flutter_cac/data/source/repository.dart';

class LoginViewModel extends ViewModel {
  bool _isLogin = false;

  bool get isLogin => _isLogin;

  bool _isUserNameValid = false;
  bool _isPasswordValid = false;
  bool _isValid = false;

  bool get isValid => _isValid;

  User _user;

  String get userId {
    if (_user != null) {
      return _user.id;
    } else {
      return "";
    }
  }

  LoginViewModel(Repository repository) : super(repository: repository) {
    repository.isLogin().then((result) {
      if (_isLogin != result) {
        _isLogin = result;
        notifyListeners();
      }
    });
  }

  void loginByWeChat() {}

  Future<User> login(String userName, String password) async {
    User user = await repository.login(userName, password).catchError((error) {
      debugPrint("login error:${error.toString()}");
    });
    return user;
  }

  Future<User> register(String userName, String password) async {
    User user = await repository.register(userName, password).catchError((error) {
      debugPrint("reigster error:${error.toString()}");
    });
    return user;
  }

  void checkUserName(String userName) {
    if (userName.trim().isNotEmpty && userName.trim().length > 0) {
      _isUserNameValid = true;
    } else {
      _isUserNameValid = false;
    }
    _checkValid();
  }

  void checkPassword(String password) {
    if (password.isNotEmpty && password.length > 5) {
      _isPasswordValid = true;
    } else {
      _isPasswordValid = false;
    }
    _checkValid();
  }

  void _checkValid() {
    bool result = _isUserNameValid && _isPasswordValid;
    debugPrint("_checkValid result:$result");
    if (_isValid != result) {
      _isValid = result;
      notifyListeners();
    }
  }
}
