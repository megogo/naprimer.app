import 'package:get/get.dart';
import 'package:naprimer_app_v2/data/token/token.dart';
import 'package:naprimer_app_v2/domain/auth/abstract_login_response.dart';
import 'package:naprimer_app_v2/domain/token/abstract_token.dart';

class LoginResponse implements AbstractLoginResponse {
  @override
  final AbstractToken token;

  @override
  String? errorMessage;

  @override
  final int statusCode;

  @override
  final String statusMessage;

  LoginResponse(
      {required this.token,
      required this.statusCode,
      required this.statusMessage,
      this.errorMessage});

  factory LoginResponse.fromResponse(Response response) {
    return LoginResponse(
      statusCode: response.statusCode!,
      statusMessage: response.statusText!,
      errorMessage: response.body["message"],
      token: Token.fromJson(response.body),
    );
  }
}
