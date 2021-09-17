import 'package:get/get.dart';

import 'base_exception.dart';

class AuthException implements BaseException {
  @override
  final int statusCode;
  @override
  final String message;

  AuthException(this.statusCode, this.message);

  factory AuthException.fromResponse(Response response) {
    int statusCode = response.statusCode ?? -1;
    String message = 'unknown exception';
    //todo we should make a documentation about errors
    if (statusCode == 400) {
      if (response.body['message'] == "user not found") {
        message = 'Wrong email or password';
      }
    }
    if (statusCode == 403) {
      if (response.body['message'] == "user not found") {
        message = 'Forbidden (403)';
      }
    }

    return AuthException(statusCode, message);
  }
}
