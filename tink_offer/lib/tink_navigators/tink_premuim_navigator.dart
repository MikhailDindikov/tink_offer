import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';
import 'package:tink_offer/tink_screens/tink_premium/tink_premium_screen.dart';

class TinkPremiumNavigator extends StatelessWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  const TinkPremiumNavigator({required this.drawerKey, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Navigator(
        key: Get.nestedKey(5),
        initialRoute: '/premium',
        observers: [HeroController()],
        onGenerateRoute: (settings) {
          if (settings.name == '/premium') {
            return GetPageRoute<dynamic>(
              page: () => TinkPremuimScreen(
                drawerKey: drawerKey,
              ),
            );
          }
          return null;
        },
      );
}
