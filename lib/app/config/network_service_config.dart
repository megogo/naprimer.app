class NetworkServiceConfig {
  // home url;
  final String baseUrl = 'http://192.168.31.54:3000/v1';
// MEGOGO office url;
// final String baseUrl = 'http://10.10.31.213:3000/v1';
// server url
// final String baseUrl = 'https://naprimer-server.k8s-qa-101.it.megogo.dev/v1';
}

class AuthConfig extends NetworkServiceConfig {
  final String clientId = "e8e64417-0fd4-4998-8f5c-7d48ae4dc0dc";
  final String signUp = '/signup';
  final String login = '/oauth/token';
}

class UserConfig extends NetworkServiceConfig {
  final String update = '/profiles';

  String findUser(String userId) => '/profiles/$userId';
}

class VideoConfig extends NetworkServiceConfig {
  final String fetchVideos = '/feed';
  final String searchVideos = '/search';

  String likeVideo(String id) => '/videos/$id/reactions/likes';

  String fetchUserVideos(String id) => '/profiles/$id/videos';
}
