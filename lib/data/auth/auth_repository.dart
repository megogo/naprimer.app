import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/config/network_service_config.dart';
import 'package:naprimer_app_v2/data/auth/signup_response.dart';
import 'package:naprimer_app_v2/data/exception/auth_exception.dart';
import 'package:naprimer_app_v2/domain/auth/abstract_auth_repository.dart';
import 'package:naprimer_app_v2/domain/auth/abstract_login_response.dart';
import 'package:naprimer_app_v2/domain/auth/abstract_signup_response.dart';
import 'package:naprimer_app_v2/services/networking/abstract_network_service.dart';

import 'login_response.dart';

class AuthRepository implements AbstractAuthRepository {
  @override
  final AbstractNetworkService networkService;
  @override
  final AuthConfig authConfig;

  AuthRepository({required this.networkService, required this.authConfig});

  @override
  Future<AbstractSignupResponse> signUp(
      {required String name,
      required String email,
      required String password}) async {
    //todo cover with logs
    Response response =
        await networkService.makeRequest(url: authConfig.signUp, body: {
      "client_id": authConfig.clientId,
      "email": email,
      "password": password,
      "name": name,
    });
    if (response.statusCode == 200) {
      return SignupResponse.fromResponse(response);
    } else {
      throw AuthException.fromResponse(response);
    }
  }

  @override
  Future<dynamic> logout() async {}

  @override
  Future<AbstractLoginResponse> login(
      {required String email, required String password}) async {
    //todo cover with logs
    print('login via email: $email and password: $password');
    Response response =
        await networkService.makeRequest(url: authConfig.login, body: {
      "client_id": authConfig.clientId,
      "email": email,
      "password": password,
      "grant_type": "password"
    });
    if (response.statusCode == 200) {
      return LoginResponse.fromResponse(response);
    } else {
      throw AuthException.fromResponse(response);
    }
  }
}
