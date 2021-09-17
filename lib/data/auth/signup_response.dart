import 'package:get/get_connect/http/src/response/response.dart';
import 'package:naprimer_app_v2/data/token/token.dart';
import 'package:naprimer_app_v2/domain/auth/abstract_signup_response.dart';
import 'package:naprimer_app_v2/domain/token/abstract_token.dart';

class SignupResponse implements AbstractSignupResponse {
  @override
  final AbstractToken token;

  @override
  String? errorMessage;

  @override
  final int statusCode;

  @override
  final String statusMessage;

  SignupResponse(
      {required this.token,
      required this.statusCode,
      required this.statusMessage,
      this.errorMessage});

  factory SignupResponse.fromResponse(Response response) =>
      SignupResponse(
        statusCode: response.statusCode!,
        statusMessage: response.statusText!,
        errorMessage: response.body["message"],
        token: Token.fromJson(response.body),
      );
}


