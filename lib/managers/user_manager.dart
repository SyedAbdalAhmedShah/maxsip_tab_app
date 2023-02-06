import 'package:maxsip/models/user_model.dart';

class UserManager {
  UserManager._privateConstructor();
  static UserModel user = UserModel();
  static final UserManager _instance = UserManager._privateConstructor();
  factory UserManager() {
    return _instance;
  }
}
