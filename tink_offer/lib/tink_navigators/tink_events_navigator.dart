import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tink_offer/tink_screens/tink_events.dart/tink_events.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';

class TinkEventsNavigator extends StatelessWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  const TinkEventsNavigator({required this.drawerKey, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Navigator(
        key: Get.nestedKey(1),
        initialRoute: '/events',
        observers: [HeroController()],
        onGenerateRoute: (settings) {
          if (settings.name == '/events') {
            return GetPageRoute<dynamic>(
              page: () => TinkEvents(
                drawerKey: drawerKey,
              ),
            );
          }
          return null;
        },
      );
}
