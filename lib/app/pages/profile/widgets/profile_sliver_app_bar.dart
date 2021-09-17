import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naprimer_app_v2/app/styling/app_colors.dart';
import 'package:naprimer_app_v2/app/styling/assets.dart';
import 'package:naprimer_app_v2/app/utils/constants.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/rounded_button.dart';

class ProfileSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String? avatar;
  final Color? bgColor;
  final String ctaLabel;
  final Function onCtaPressed;

  ProfileSliverAppBar(
      {required this.avatar,
      required this.expandedHeight,
      required this.bgColor,
      required this.ctaLabel,
      required this.onCtaPressed});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double opacityForAppBar = (1 - shrinkOffset / expandedHeight);
    final double opacityForBackground = shrinkOffset / expandedHeight;
    final double marginTopAvatar = expandedHeight / 1.5 - shrinkOffset;
    final Color _bgColor = bgColor ?? AppColors.backgroundDefaultProfileColor;
    return Container(
      color: Colors.black.withOpacity(opacityForBackground),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Container(
            color: _bgColor.withOpacity(opacityForAppBar),
          ),
          Positioned(
              left: 10.0,
              top: marginTopAvatar,
              child: _buildAvatar(expandedHeight, shrinkOffset, avatar)),
          Positioned(top: 22, right: defaultPadding, child: _buildCta()),
        ],
      ),
    );
  }

  Widget _buildAvatar(
      double expandedHeight, double shrinkOffset, String? avatar) {
    final double opacity = (1 - shrinkOffset / expandedHeight);
    return Opacity(
      opacity: opacity,
      child: Card(
        color: Colors.transparent,
        shape: CircleBorder(),
        elevation: 8,
        child: CircleAvatar(
          maxRadius: 44,
          minRadius: 44,
          child: Image.asset(Assets.defaultAvatar),
          //todo still error occurs :/
          // child: Image.network(avatar!,
          //     errorBuilder: (context, object, stackTrace) {
          //   return Image.asset(Assets.defaultAvatar);
          // }),
        ),
      ),
    );
  }

  Widget _buildCta() {
    return RoundedButton(label: ctaLabel, onTap: () => onCtaPressed());
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight * 1.6;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
