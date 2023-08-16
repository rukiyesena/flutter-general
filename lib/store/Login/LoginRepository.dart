import 'Login.dart';

abstract class LoginRepository {
  Future<LoginState> fetchLoginState(
      String userCompanyId, String userName, String userPassword);
}

class LoginStateRepository implements LoginRepository {
  @override
  Future<LoginState> fetchLoginState(
      String userCompanyId, String userName, String userPassword) async {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return LoginState(
            userCompanyId: userCompanyId,
            userName: userName,
            userPassword: userPassword);
      },
    );
  }
}

class NetworkException implements Exception {}
