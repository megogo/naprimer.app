import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/routing/pages.dart';

class ForYouRoot extends StatefulWidget {
  const ForYouRoot({Key? key}) : super(key: key);

  @override
  _ForYouRootState createState() => _ForYouRootState();
}

class _ForYouRootState extends State<ForYouRoot> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    ForYouPages.navigatorKeyId = navigatorKey.hashCode;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(ForYouPages.navigatorKeyId),
      initialRoute: ForYouPages.INITIAL,
      onGenerateRoute: ForYouPages.onGenerateRoute,
    );
  }
}
