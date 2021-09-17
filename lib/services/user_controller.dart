import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user_repository.dart';

class UserController extends ChangeNotifier{
  late Rx<AbstractUser?> user;
  final AbstractUserRepository userRepository;

  UserController(this.userRepository);

  Future<void> saveUser(AbstractUser user) async {
    await userRepository.saveUser(user);
    this.user.value = user;
  }

  Future<void> loadUser() async {
    user = (await userRepository.loadUser()).obs;
    this.user = user;
  }

  Future<void> updateUser(AbstractUser user) async {
    await userRepository.updateUser(user);
  }

  Future<void> logout() async {
    await userRepository.logout();
    this.user.value = null;
  }
}