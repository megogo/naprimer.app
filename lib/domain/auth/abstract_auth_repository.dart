import 'package:naprimer_app_v2/app/config/network_service_config.dart';
import 'package:naprimer_app_v2/domain/common/abstract_base_repository.dart';
import 'package:naprimer_app_v2/services/networking/abstract_network_service.dart';

import 'abstract_login_response.dart';
import 'abstract_signup_response.dart';

abstract class AbstractAuthRepository extends AbstractBaseRepository {
  final AuthConfig authConfig;

  AbstractAuthRepository(
      {required AbstractNetworkService networkService, required this.authConfig})
      : super(networkService: networkService);

  Future<AbstractSignupResponse> signUp(
      {required String name, required String email, required String password});

  Future<AbstractLoginResponse> login({required String email, required String password});

  Future<dynamic> logout();
}
