import 'package:flutter/widgets.dart';
import 'package:naprimer_app_v2/app/pages/profile/profile_tab_type.dart';
import 'package:naprimer_app_v2/app/styling/app_text_theme.dart';
import 'package:naprimer_app_v2/app/widgets/buttons/rounded_button.dart';

class NoVideosWidget extends StatelessWidget {
  const NoVideosWidget({Key? key, required this.profileTabType}) : super(key: key);
  final ProfileTabType profileTabType;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(profileTabType.label, style: AppTextTheme.titleTextStyle2),
          const SizedBox(height: 8),
          Text(profileTabType.forNoVideosPlugText,
              style: AppTextTheme.profileTabDescriptionStyle),
          const SizedBox(height: 24),
          Visibility(
            visible: profileTabType != ProfileTabType.Likes,
            child: RoundedButton(
                label: 'Create',
                onTap: () {
                  //todo when create page will be done this part of profile should be completed
                }),
          ),
        ],
      ),
    );
  }
}
