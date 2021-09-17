import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/auth/login/login_controller.dart';
import 'package:naprimer_app_v2/app/styling/app_text_theme.dart';
import 'package:naprimer_app_v2/app/utils/text_validator.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/large_button.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/show_hide_password_button.dart';
import 'package:naprimer_app_v2/app/widgets/text/styled_text_field.dart';

enum LoginTryState { none, success, error }

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder(
            builder: (LoginController controller) {
              return Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBackButton(),
                    const Text("Log in",
                        textAlign: TextAlign.start,
                        style: AppTextTheme.titleTextStyle),
                    _buildErrorMessage(),
                    Form(
                      key: controller.formKey,
                      onChanged: controller.onFormChanged,
                      child: Column(
                        children: [
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
                    const SizedBox(
                      height: 16,
                    ),
                    GetBuilder(
                        id: controller.loginBtnId,
                        builder: (LoginController controller) {
                          return LargeButton(
                            onTap: controller.onLoginPressed,
                            label: 'Login',
                            isLoading: controller.isLoading,
                          );
                        }),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return IconButton(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: controller.onBackPressed);
  }

  Widget _buildErrorMessage() {
    Widget widget = const SizedBox(height: 20);
    if (controller.loginTryState == LoginTryState.error)
      widget = Container(
        height: 20,
        alignment: Alignment.centerLeft,
        child:  Text(
          controller.errorMessage,
          textAlign: TextAlign.start,
          style: AppTextTheme.errorMessageStyle,
        ),
      );
    return widget;
  }
}
