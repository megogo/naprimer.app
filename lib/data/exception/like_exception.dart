import 'package:get/get.dart';
import 'package:naprimer_app_v2/data/exception/base_exception.dart';

class LikeException implements BaseException {
  @override
  final int statusCode;
  @override
  final String message;

  LikeException(this.statusCode, this.message);

  factory LikeException.fromResponse(Response response) {
    int statusCode = response.statusCode ?? -1;
    String message = 'unknown exception';
    //todo we should make a documentation about errors
    if (statusCode == 400) {
      if (response.body['message'] == "video not found") {
        message = 'Some message';
      }
    }

    return LikeException(statusCode, message);
  }
}
