import 'package:naprimer_app_v2/app/config/network_service_config.dart';
import 'package:naprimer_app_v2/domain/common/abstract_base_repository.dart';
import 'package:naprimer_app_v2/domain/token/abstract_token.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user.dart';
import 'package:naprimer_app_v2/services/networking/abstract_network_service.dart';
import 'package:naprimer_app_v2/services/storage/abstract_db_service.dart';

abstract class AbstractUserRepository extends AbstractBaseRepository {
  final AbstractDbService dbService;
  final UserConfig userConfig;

  AbstractUserRepository(
      {required this.userConfig,
      required AbstractNetworkService networkService,
      required this.dbService})
      : super(networkService: networkService);

  Future<dynamic> saveUser(AbstractUser user);

  Future<dynamic> logout();

  Future<AbstractUser?> loadUser();

  Future<AbstractToken?> loadToken();

  Future<dynamic> saveToken(AbstractToken token);

  Future<dynamic> updateUser(AbstractUser user);

  Future<AbstractUser> findUserById(String id);
}
