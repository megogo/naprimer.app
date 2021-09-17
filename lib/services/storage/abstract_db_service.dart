import 'package:naprimer_app_v2/services/storage/db_client.dart';

abstract class AbstractDbService {
  const AbstractDbService(final DbClient dbClient);

  Future<dynamic> save(String key, dynamic value);

  Future<dynamic> load(String key);
}
