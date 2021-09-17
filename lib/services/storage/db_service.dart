import 'package:naprimer_app_v2/services/storage/abstract_db_service.dart';
import 'package:naprimer_app_v2/services/storage/db_client.dart';

class DbService extends AbstractDbService {
  final DbClient client;

  const DbService({required this.client}) : super(client);

  @override
  Future<dynamic> load(String key) async {
    return client.read(key);
  }

  @override
  Future<dynamic> save(String key, dynamic value) {
    return client.write(key, value);
  }
}

abstract class DbKeys {
  static final userKey = 'user_key';
}
