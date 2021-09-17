import 'package:get_storage/get_storage.dart';

class DbClient {
  static final DbClient _instance = DbClient._internal();

  factory DbClient() {
    return _instance;
  }

  DbClient._internal();

  static const _STORAGE_KEY = 'naprimerAppStorageBox';
  static late GetStorage _storageBox;

  Future<dynamic> init() async {
    await GetStorage.init(_STORAGE_KEY);
    _storageBox = GetStorage(_STORAGE_KEY);
    return this;
  }

  Future<void> write(String key, dynamic value) {
    return _storageBox.write(key, value);
  }

  Future<dynamic> read(String key) async{
    return _storageBox.read(key);
  }
}
