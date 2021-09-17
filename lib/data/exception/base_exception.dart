
abstract class BaseException {
  final int statusCode;
  final String message;

  BaseException(this.statusCode, this.message);
}