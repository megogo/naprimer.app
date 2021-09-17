import 'package:naprimer_app_v2/domain/user/abstract_user.dart';

abstract class AbstractToken {
  final String accessToken;
  final int expiry;
  final String refreshToken;
  final String scope;
  final String tokenType;
  final String userId;
  final AbstractUser user;

  AbstractToken(
      {required this.accessToken,
      required this.expiry,
      required this.refreshToken,
      required this.scope,
      required this.tokenType,
      required this.userId,
      required this.user});
}
