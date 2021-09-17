import 'package:naprimer_app_v2/services/networking/network_client.dart';

enum RequestMethod { GET, POST, PATCH, DELETE }

abstract class AbstractNetworkService {
  AbstractNetworkService(final NetworkClient _networkClient);

  void addHeader({required String key, required String value});

  void setBaseUrl(String baseUrl);

  Future<dynamic> makeRequest(
      {required String url,
      RequestMethod requestMethod = RequestMethod.POST,
      dynamic body,
      String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      dynamic decoder,
      dynamic uploadProgress});
}
