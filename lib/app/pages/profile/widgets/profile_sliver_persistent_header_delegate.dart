import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  ProfileSliverPersistentHeaderDelegate(
      {required this.tabBar, this.backgroundColor, this.padding});

  final TabBar tabBar;
  Color? backgroundColor;
  EdgeInsets? padding;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      padding: padding,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(ProfileSliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;
}
