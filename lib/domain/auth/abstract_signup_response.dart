
import 'package:naprimer_app_v2/domain/common/abstract_base_response.dart';
import 'package:naprimer_app_v2/domain/token/abstract_token.dart';

abstract class AbstractSignupResponse extends AbstractBaseResponse {
  final AbstractToken token;

  AbstractSignupResponse(
      {required this.token,
      required statusCode,
      required errorMessage,
      required statusMessage})
      : super(
            statusCode: statusCode,
            errorMessage: errorMessage,
            statusMessage: statusMessage);
}
