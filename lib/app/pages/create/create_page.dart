import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_controller.dart';

class CreatePage extends GetView<CreateController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: const Text('create'),
      ),
    );
  }
}
