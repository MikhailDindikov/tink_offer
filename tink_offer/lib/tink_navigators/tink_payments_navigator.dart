import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';
import 'package:tink_offer/tink_screens/tink_payments/tink_payments.dart';

class TinkPaymentsNavigator extends StatelessWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  const TinkPaymentsNavigator({required this.drawerKey, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Navigator(
        key: Get.nestedKey(0),
        initialRoute: '/payments',
        observers: [HeroController()],
        onGenerateRoute: (settings) {
          if (settings.name == '/payments') {
            return GetPageRoute<dynamic>(
              page: () => TinkPayments(
                drawerKey: drawerKey,
              ),
            );
          }
          return null;
        },
      );
}
