import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/settings/edit/settings_edit_controller.dart';
import 'package:naprimer_app_v2/app/styling/app_text_theme.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/large_button.dart';
import 'package:naprimer_app_v2/app/widgets/text/styled_text_field.dart';

class SettingsEditPage extends GetView<SettingsEditController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: GetBuilder(builder: (SettingsEditController controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(
                  title: controller.appBarTitle,
                  onBackPressed: controller.onBackPressed),
              const SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: StyledTextField.standard(
                  labelText: controller.fieldTitle,
                  controller: controller.controller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: controller.validate,
                ),
              ),
              _buildErrorMessage(),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
                ),
                child: GetBuilder(
                    id: controller.doneBtnId,
                    builder: (SettingsEditController controller) {
                      return LargeButton(
                        onTap: controller.onDonePressed,
                        isLoading: controller.isLoading,
                        isBlocked: !controller.isValid,
                        label: 'Done',
                      );
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildAppBar(
      {required String title, required Function onBackPressed}) {
    return Container(
      padding: EdgeInsets.only(top: 32),
      height: kToolbarHeight,
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: IconButton(
              padding: EdgeInsets.only(left: 24),
              onPressed: () => onBackPressed(),
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Text(title, style: AppTextTheme.appBarStyle),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage() {
    Widget widget = const SizedBox(height: 0);
    if (controller.editTryState == EditTryState.error)
      widget = Container(
        height: 20,
        margin: const EdgeInsets.all(16.0),
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
