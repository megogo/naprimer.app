import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/auth/sign_up/sign_up_controller.dart';
import 'package:naprimer_app_v2/app/styling/app_text_theme.dart';
import 'package:naprimer_app_v2/app/utils/text_validator.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/large_button.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/show_hide_password_button.dart';
import 'package:naprimer_app_v2/app/widgets/text/styled_text_field.dart';

enum PasswordType { none, weak, good, great }
enum SignUpTryState { none, error }

extension PasswordTypeData on PasswordType {
  String get label {
    switch (this) {
      case PasswordType.none:
        return 'No password';
      case PasswordType.weak:
        return 'Weak password';
      case PasswordType.good:
        return 'Good password';
      case PasswordType.great:
        return 'Great password 🎉';
    }
  }
}

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GetBuilder(
              builder: (SignUpController controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBackButton(controller),
                    _buildTitle(),
                    _buildErrorMessage(),
                    Form(
                      key: controller.formKey,
                      onChanged: controller.onFormChanged,
                      child: Column(
                        children: [
                          StyledTextField.standard(
                              controller: controller.nameController,
                              labelText: 'Name',
                              autoFocus: true,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: TextFieldValidator.name),
                          const SizedBox(
                            height: 20,
                          ),
                          StyledTextField.standard(
                              controller: controller.emailController,
                              labelText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(' '),
                              ],
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: TextFieldValidator.email),
                          const SizedBox(
                            height: 20,
                          ),
                          StyledTextField.standard(
                            controller: controller.passwordController,
                            labelText: "Password",
                            obscureText: !controller.isPasswordVisible,
                            maxLines: 1,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: TextFieldValidator.password,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(' '),
                            ],
                            suffixIcon: ShowHidePasswordButton(
                              onTap: controller.togglePasswordVisibility,
                              isVisible: controller.isPasswordVisible,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildPasswordNote(controller.passwordType),
                    GetBuilder(
                        id: controller.signUpBtnId,
                        builder: (SignUpController c) {
                          return LargeButton(
                            onTap: c.onSignUpPressed,
                            label: 'Sign up',
                            isLoading: controller.isLoading,
                            isBlocked: !controller.isValid,
                          );
                        }),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(SignUpController controller) {
    return IconButton(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: controller.onBackPressed);
  }

  Widget _buildTitle() {
    return Text(
      "Sign up",
      textAlign: TextAlign.start,
      style: AppTextTheme.titleTextStyle,
    );
  }

  Widget _buildPasswordNote(PasswordType passwordType) {
    switch (passwordType) {
      case PasswordType.none:
      case PasswordType.weak:
        return const SizedBox(
          height: 16,
        );
      case PasswordType.good:
      case PasswordType.great:
        return Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
          child: Text(
            passwordType.label,
            style:
                TextStyle(fontSize: 14, color: Color.fromRGBO(0, 175, 133, 1)),
          ),
        );
    }
  }

  Widget _buildErrorMessage() {
    Widget widget = const SizedBox(height: 20);
    if (controller.signUpTryState == SignUpTryState.error)
      widget = Container(
        height: 20,
        alignment: Alignment.centerLeft,
        child: Text(
          controller.errorMessage,
          textAlign: TextAlign.start,
          style: AppTextTheme.errorMessageStyle,
        ),
      );
    return widget;
  }
}
