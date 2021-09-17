import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naprimer_app_v2/app/styling/assets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(75.0),
        child: Image.asset(
          Assets.splashScreenImage,
        ),
      ),
    );
  }
}
