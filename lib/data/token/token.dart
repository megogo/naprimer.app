import 'dart:convert';

import 'package:naprimer_app_v2/data/user/user.dart';
import 'package:naprimer_app_v2/domain/token/abstract_token.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user.dart';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token implements AbstractToken {
  Token({
    required this.accessToken,
    required this.expiry,
    required this.idToken,
    required this.refreshToken,
    required this.scope,
    required this.tokenType,
    required this.userId,
    required this.user,
  });

  final String accessToken;
  final int expiry;
  final String idToken;
  final String refreshToken;
  final String scope;
  final String tokenType;
  final String userId;
  final AbstractUser user;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["access_token"],
        expiry: json["expiry"],
        idToken: json["id_token"],
        refreshToken: json["refresh_token"],
        scope: json["scope"],
        tokenType: json["token_type"],
        userId: json["user_id"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "expiry": expiry,
        "id_token": idToken,
        "refresh_token": refreshToken,
        "scope": scope,
        "token_type": tokenType,
        "user_id": userId,
        "user": userToJson(user as User),
      };
}
