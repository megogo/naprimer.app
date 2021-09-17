import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/config/network_service_config.dart';
import 'package:naprimer_app_v2/data/exception/auth_exception.dart';
import 'package:naprimer_app_v2/data/user/user.dart';
import 'package:naprimer_app_v2/domain/token/abstract_token.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user_repository.dart';
import 'package:naprimer_app_v2/services/networking/abstract_network_service.dart';
import 'package:naprimer_app_v2/services/storage/abstract_db_service.dart';
import 'package:naprimer_app_v2/services/storage/db_service.dart';

class UserRepository implements AbstractUserRepository {
  @override
  final AbstractNetworkService networkService;

  @override
  final UserConfig userConfig;

  @override
  final AbstractDbService dbService;

  const UserRepository(this.dbService, this.networkService, this.userConfig);

  @override
  Future<AbstractUser?> loadUser() async {
    String? json = await this.dbService.load(DbKeys.userKey);
    return json == null ? null : userFromJson(json);
  }

  @override
  Future<dynamic> saveUser(AbstractUser? user) async {
    return await this.dbService.save(DbKeys.userKey, userToJson(user as User));
  }

  @override
  Future<AbstractToken?> loadToken() {
    // TODO: implement loadToken
    throw UnimplementedError();
  }

  @override
  Future saveToken(AbstractToken token) {
    // TODO: implement saveToken
    throw UnimplementedError();
  }

  @override
  Future<dynamic> updateUser(AbstractUser user) async {
    Response response = await networkService.makeRequest(
      url: '${userConfig.update}/${user.id}',
      requestMethod: RequestMethod.PATCH,
      body: {
        'nickname': user.nickname,
        'name': user.name,
      },
    );
    if (response.statusCode != 200) {
      throw AuthException.fromResponse(response);
    }
  }

  @override
  Future<void> logout() async {
    return await this.dbService.save(DbKeys.userKey, null);
  }

  @override
  Future<AbstractUser> findUserById(String id) async {
    Response response = await networkService.makeRequest(
      url: userConfig.findUser(id),
      requestMethod: RequestMethod.GET,
    );
    if (response.statusCode != 200) {
      throw AuthException.fromResponse(response);
    } else {
      return User.fromJson(response.body);
    }
  }
}
