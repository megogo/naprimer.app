import 'package:naprimer_app_v2/app/config/network_service_config.dart';
import 'package:naprimer_app_v2/services/networking/network_client.dart';

import 'abstract_network_service.dart';

class NetworkService extends AbstractNetworkService {
  final NetworkClient _networkClient;

  NetworkService(this._networkClient) : super(_networkClient);

  get _client => _networkClient.httpClient;

  Future<NetworkService> init({required NetworkServiceConfig config}) async {
    _client.baseUrl = config.baseUrl;
    return this;
  }

  @override
  void addHeader({required String key, required String value}) {
    _client.addRequestModifier<dynamic>((request) {
      request.headers[key] = value;
      return request;
    });
  }

  @override
  void setBaseUrl(String baseUrl) {
    _client.baseUrl = baseUrl;
  }

  @override
  Future<dynamic> makeRequest(
      {required String url,
      RequestMethod requestMethod = RequestMethod.POST,
      dynamic body,
      String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      decoder,
      uploadProgress}) async {
    switch (requestMethod) {
      case RequestMethod.GET:
        return _executeGetRequest(url,
            headers: headers, contentType: contentType, query: query);
      case RequestMethod.POST:
        return _executePostRequest(url,
            headers: headers,
            body: body,
            contentType: contentType,
            query: query,
            decoder: decoder,
            uploadProgress: uploadProgress);
      case RequestMethod.PATCH:
        return _executePatchRequest(url,
            headers: headers,
            body: body,
            contentType: contentType,
            query: query,
            decoder: decoder,
            uploadProgress: uploadProgress);
      case RequestMethod.DELETE:
        return _executeDeleteRequest(url,
            headers: headers,
            contentType: contentType,
            query: query,
            decoder: decoder);
    }
  }

  Future _executeGetRequest(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
  }) async {
    return _client.get(url,
        headers: headers, contentType: contentType, query: query);
  }

  Future _executePostRequest(
    String? url, {
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    dynamic decoder,
    dynamic uploadProgress,
  }) {
    return _client.post(url,
        body: body,
        contentType: contentType,
        headers: headers,
        query: query,
        decoder: decoder,
        uploadProgress: uploadProgress);
  }

  Future _executePatchRequest(
    String url, {
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    dynamic decoder,
    dynamic uploadProgress,
  }) {
    return _client.patch(
      url,
      body: body,
      contentType: contentType,
      headers: headers,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  Future _executeDeleteRequest(
    String url, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    dynamic decoder,
  }) {
    return _client.delete(
      url,
      contentType: contentType,
      headers: headers,
      query: query,
      decoder: decoder,
    );
  }
}
