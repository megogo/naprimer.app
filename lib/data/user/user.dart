import 'dart:convert';

import 'package:naprimer_app_v2/domain/user/abstract_user.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User implements AbstractUser {
  User({
    required this.id,
    required this.avatar,
    required this.clientId,
    required this.email,
    required this.name,
    required this.nickname,
  });

  String id;
  String? avatar;
  String? clientId;
  String email;
  String name;
  String? nickname;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        avatar: json["avatar"],
        clientId: json["client_id"],
        email: json["email"],
        name: json["name"],
        nickname: json["nickname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "client_id": clientId,
        "email": email,
        "name": name,
        "nickname": nickname,
      };

  factory User.copy(User user) {
    return User(
      id: user.id,
      avatar: user.avatar,
      clientId: user.clientId,
      email: user.email,
      name: user.name,
      nickname: user.nickname,
    );
  }
}
