import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/auth/login/login_page.dart';
import 'package:naprimer_app_v2/app/pages/home/bottom_nav_bar_menu.dart';
import 'package:naprimer_app_v2/app/pages/home/home_page_arguments.dart';
import 'package:naprimer_app_v2/app/routing/pages.dart';
import 'package:naprimer_app_v2/data/auth/auth_repository.dart';
import 'package:naprimer_app_v2/data/exception/auth_exception.dart';
import 'package:naprimer_app_v2/domain/auth/abstract_auth_repository.dart';
import 'package:naprimer_app_v2/domain/auth/abstract_login_response.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user.dart';
import 'package:naprimer_app_v2/services/user_controller.dart';

class LoginController extends GetxController {
  final int loginBtnId = 1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AbstractAuthRepository _authRepository;
  late LoginTryState _loginTryState;

  LoginTryState get loginTryState => _loginTryState;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool _isPasswordVisible;
  late bool _isLoading;
  late String _errorMessage;

  bool get isLoading => _isLoading;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  GlobalKey<FormState> get formKey => _formKey;

  bool get isPasswordVisible => _isPasswordVisible;

  String get errorMessage => _errorMessage;

  @override
  void onInit() {
    _authRepository = Get.find<AuthRepository>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _loginTryState = LoginTryState.none;
    _isLoading = false;
    _isPasswordVisible = false;
    _errorMessage = 'Something went wrong';
    super.onInit();
  }

  void onBackPressed() {
    Get.back();
  }

  void onFormChanged() {
    _loginTryState = LoginTryState.none;
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    update();
  }

  void onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      _startLoading([loginBtnId]);

      try {
        AbstractLoginResponse response = await this._authRepository.login(
            email: _emailController.text, password: passwordController.text);
        await _saveUser(response.token.user);
        _stopLoading();
        Get.offAllNamed(Routes.HOME,
            arguments: HomePageArguments(selectedTab: BottomNavBarMenu.ForYou));
      } on AuthException catch (exception) {
        _errorMessage = exception.message;
        _loginTryState = LoginTryState.error;
        _stopLoading();
      }
    }
  }

  Future<void> _saveUser(AbstractUser user) async {
    UserController c = Get.find<UserController>();
    await c.saveUser(user);
  }

  void _startLoading(List<int>? ids) {
    _isLoading = true;
    update(ids);
  }

  void _stopLoading({List<int>? ids}) {
    _isLoading = false;
    update(ids);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
