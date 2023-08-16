import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String username = "";
  String access_token = "";


  void login(String name, String token){
    username = name;
    access_token = token;
    notifyListeners();
  }
  void logout(){
    username = "";
    access_token = "";
    notifyListeners();
  }
}