import 'package:get/get.dart';

import 'base_exception.dart';

class UserException implements BaseException {
  @override
  final int statusCode;
  @override
  final String message;

  UserException(this.statusCode, this.message);

  factory UserException.fromResponse(Response response) {
    int statusCode = response.statusCode ?? -1;
    String message = 'unknown exception';
    //todo we should make a documentation about errors
    //todo we need to discuss what errors can be here
    if (statusCode == 400) {
      if (response.body['message'] == "user not found") {
        message = 'Need to define error';
      }
    }
    if (statusCode == 403) {
      if (response.body['message'] == "user not found") {
        message = 'Forbidden (403)';
      }
    }

    return UserException(statusCode, message);
  }
}
