import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';
import 'package:tink_offer/tink_screens/tink_summary/tink_summary_screen.dart';

class TinkSummaryNavigator extends StatelessWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  const TinkSummaryNavigator({required this.drawerKey, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Navigator(
        key: Get.nestedKey(3),
        initialRoute: '/summary',
        observers: [HeroController()],
        onGenerateRoute: (settings) {
          if (settings.name == '/summary') {
            return GetPageRoute<dynamic>(
              page: () => TinkSummaryScreen(
                drawerKey: drawerKey,
              ),
            );
          }
          return null;
        },
      );
}
