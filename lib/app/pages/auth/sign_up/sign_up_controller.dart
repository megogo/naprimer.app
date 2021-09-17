import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/auth/sign_up/sign_up_page.dart';
import 'package:naprimer_app_v2/app/pages/home/bottom_nav_bar_menu.dart';
import 'package:naprimer_app_v2/app/pages/home/home_page_arguments.dart';
import 'package:naprimer_app_v2/app/routing/pages.dart';
import 'package:naprimer_app_v2/app/utils/text_validator.dart';
import 'package:naprimer_app_v2/data/auth/auth_repository.dart';
import 'package:naprimer_app_v2/data/exception/auth_exception.dart';
import 'package:naprimer_app_v2/domain/auth/abstract_auth_repository.dart';
import 'package:naprimer_app_v2/domain/auth/abstract_signup_response.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user.dart';
import 'package:naprimer_app_v2/services/user_controller.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final int signUpBtnId = 1;

  late AbstractAuthRepository _authRepository;

  late bool _isLoading;

  late bool _isValid;

  late bool _isPasswordVisible;

  late PasswordType _passwordType;
  late SignUpTryState _signUpTryState;

  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  late String _errorMessage;

  bool get isLoading => _isLoading;

  bool get isValid => _isValid;

  bool get isPasswordVisible => _isPasswordVisible;

  PasswordType get passwordType => _passwordType;

  SignUpTryState get signUpTryState => _signUpTryState;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get nameController => _nameController;

  TextEditingController get emailController => _emailController;

  String get errorMessage => _errorMessage;

  @override
  void onInit() {
    _passwordController = TextEditingController()
      ..addListener(_onPasswordChanged);
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _isPasswordVisible = false;
    _isLoading = false;
    _isValid = false;
    _signUpTryState = SignUpTryState.none;
    _passwordType = PasswordType.none;
    _authRepository = Get.find<AuthRepository>();
    _errorMessage = 'Something went wrong';
    super.onInit();
  }

  void onBackPressed() {
    Get.back();
  }

  void onFormChanged() {
    _isValid = TextFieldValidator.email(_emailController.text) == null &&
        TextFieldValidator.name(_nameController.text) == null &&
        TextFieldValidator.password(_passwordController.text) == null;
    _signUpTryState = SignUpTryState.none;
    update();
  }

  void _onPasswordChanged() {
    String value = _passwordController.text;
    final complexity = TextFieldValidator.passwordComplexity(value);
    PasswordType newPasswordType = PasswordType.weak;
    if (complexity == 2) {
      newPasswordType = PasswordType.good;
    } else if (complexity >= 3) {
      newPasswordType = PasswordType.great;
    }

    if (newPasswordType != _passwordType) {
      _passwordType = newPasswordType;
      update();
    }
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    update();
  }

  void onSignUpPressed() async {
    if (formKey.currentState!.validate()) {
      _startLoading([signUpBtnId]);

      try {
        AbstractSignupResponse response = await this._authRepository.signUp(
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text);
        _saveUser(response.token.user);
        _stopLoading();

        Get.offAllNamed(Routes.HOME,
            arguments: HomePageArguments(selectedTab: BottomNavBarMenu.ForYou));
      } on AuthException catch (exception) {
        _errorMessage = exception.message;
        _signUpTryState = SignUpTryState.error;
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
    _passwordController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
