import 'package:naprimer_app_v2/domain/common/abstract_base_response.dart';
import 'package:naprimer_app_v2/domain/token/abstract_token.dart';

abstract class AbstractLoginResponse extends AbstractBaseResponse {
  final AbstractToken token;

  AbstractLoginResponse(
      {required this.token,
      required statusCode,
      required errorMessage,
      required statusMessage})
      : super(
            statusCode: statusCode,
            errorMessage: errorMessage,
            statusMessage: statusMessage);
}
