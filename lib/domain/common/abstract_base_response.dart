abstract class AbstractBaseResponse {
  final int statusCode;
  final String statusMessage;
  final String? errorMessage;

  AbstractBaseResponse({
    required this.statusCode,
    required this.errorMessage,
    required this.statusMessage,
  });
}
