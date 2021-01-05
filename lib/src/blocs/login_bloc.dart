import 'dart:async';

import 'package:flutter_app/src/validators/validations.dart';

class LoginBloc {
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();

  Stream get userStream => _userController.stream;

  Stream get passStream => _passController.stream;

  bool isValidInfo(String user, String pass) {
    if (!Validations.isValidUser(user)) {
      _userController.sink.addError("Please enter user name");
      return false;
    }
    if (Validations.isValidPass(pass) == 0) {
      _passController.sink.addError("Please enter password");
      return false;
    } else if (Validations.isValidPass(pass) == 1) {
      _passController.sink.addError("Password includes 6 characters");
      return false;
    }
    return true;
  }

  void clearErr() {
    _userController.sink.add('OK');
    _passController.sink.add('OK');
  }

  void dispose() {
    _userController.close();
    _passController.close();
  }
}
