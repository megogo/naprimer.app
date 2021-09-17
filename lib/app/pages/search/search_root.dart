import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naprimer_app_v2/app/routing/pages.dart';

class SearchRoot extends StatefulWidget {
  const SearchRoot({Key? key}) : super(key: key);

  @override
  _ForYouRootState createState() => _ForYouRootState();
}

class _ForYouRootState extends State<SearchRoot> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    SearchPages.navigatorKeyId = navigatorKey.hashCode;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(SearchPages.navigatorKeyId),
      initialRoute: SearchPages.INITIAL,
      onGenerateRoute: SearchPages.onGenerateRoute,
    );
  }
}
