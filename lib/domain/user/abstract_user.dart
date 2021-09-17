abstract class AbstractUser {
  AbstractUser({
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
}
