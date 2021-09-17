import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/pages/settings/field_type.dart';
import 'package:naprimer_app_v2/app/utils/text_validator.dart';
import 'package:naprimer_app_v2/data/exception/base_exception.dart';
import 'package:naprimer_app_v2/data/user/user.dart';
import 'package:naprimer_app_v2/domain/user/abstract_user.dart';
import 'package:naprimer_app_v2/services/user_controller.dart';

enum EditTryState { none, loading, success, error }

class SettingsEditArguments {
  final FieldType fieldType;

  SettingsEditArguments({required this.fieldType});
}

class SettingsEditController extends GetxController {
  final SettingsEditArguments settingsEditArguments;
  final int _doneBtnId = 1;
  late UserController _userController;
  late EditTryState _editTryState;
  late bool _isValid;

  late TextEditingController _controller;
  late String _errorMessage;

  SettingsEditController({required this.settingsEditArguments});

  FieldType get fieldType => settingsEditArguments.fieldType;

  EditTryState get editTryState => _editTryState;

  String get appBarTitle => 'Edit ${fieldType.label.toLowerCase()}';

  String get fieldTitle => settingsEditArguments.fieldType.label;

  TextEditingController get controller => _controller;

  bool get isValid => _isValid;

  bool get isLoading => _editTryState == EditTryState.loading;

  int get doneBtnId => _doneBtnId;

  String get errorMessage => _errorMessage;

  @override
  void onInit() {
    _userController = Get.find<UserController>();
    _editTryState = EditTryState.none;
    _controller = TextEditingController();
    _isValid = false;
    _initValue();
    _controller.addListener(() {
      if (editTryState == EditTryState.error) {
        _editTryState = EditTryState.none;
      }
      _isValid = validate(_controller.text) == null;
      update([_doneBtnId]);
    });
    super.onInit();
  }

  @override
  void dispose() {
    _controller.dispose();
    //todo need to clarify
    _errorMessage = 'Error message';
    super.dispose();
  }

  String? validate(String? value) {
    switch (fieldType) {
      case FieldType.Name:
        if (value == Get.find<UserController>().user.value!.name) {
          return 'Can\'t save same name';
        }
        return TextFieldValidator.name(value);
      case FieldType.Username:
        if (value == Get.find<UserController>().user.value!.nickname) {
          return 'Can\'t save same username';
        }
        return TextFieldValidator.userName(value);
      default:
        return null;
    }
  }

  void _initValue() {
    switch (fieldType) {
      case FieldType.Name:
        _controller.text = Get.find<UserController>().user.value!.name;
        break;
      case FieldType.Username:
        //todo should be checked if this is correct
        _controller.text =
            Get.find<UserController>().user.value!.nickname ?? 'No nickname';
        break;
    }
  }

  void onDonePressed() async {
    AbstractUser user = User.copy(_userController.user.value as User);
    switch (fieldType) {
      case FieldType.Name:
        user.name = _controller.text;
        break;
      case FieldType.Username:
        user.nickname = _controller.text;
        break;
    }
    _startLoading([_doneBtnId]);
    await _updateAndSaveUser(user);
  }

  Future<void> _updateAndSaveUser(AbstractUser user) async {
    try {
      await _userController.updateUser(user);
      await _userController.saveUser(user);
      _stopLoading();
      onBackPressed();
    } on BaseException catch (exception) {
      _errorMessage = exception.message;
      _editTryState = EditTryState.error;
      update();
    }
  }

  void _startLoading(List<int>? ids) {
    _editTryState = EditTryState.loading;
    update(ids);
  }

  void _stopLoading({List<int>? ids}) {
    _editTryState = EditTryState.none;
    update(ids);
  }

  onBackPressed() => Get.back();
}
