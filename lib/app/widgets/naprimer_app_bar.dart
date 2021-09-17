import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';

class NaprimerAppBar {
  static SliverAppBar sliver(
      {required String title, bool isImplementLeading = false}) {
    return SliverAppBar(
      automaticallyImplyLeading: isImplementLeading,
      centerTitle: false,
      pinned: true,
      expandedHeight: kToolbarHeight * 1.5,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16, right: 16.0),
        centerTitle: false,
        title: Text(
          title,
          style: TextStyle(
              color: AppColors.white, fontWeight: FontWeight.bold, height: 1.4),
        ),
      ),
    );
  }
}
