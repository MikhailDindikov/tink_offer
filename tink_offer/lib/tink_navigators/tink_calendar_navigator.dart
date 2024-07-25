import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tink_offer/tink_screens/tink_calendar/tink_calendar_screen.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';

class TinkCalendarNavigator extends StatelessWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  const TinkCalendarNavigator({required this.drawerKey, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Navigator(
        key: Get.nestedKey(2),
        initialRoute: '/calendar',
        observers: [HeroController()],
        onGenerateRoute: (settings) {
          if (settings.name == '/calendar') {
            return GetPageRoute<dynamic>(
              page: () => TinkCalendarScreen(
                drawerKey: drawerKey,
              ),
            );
          }
          return null;
        },
      );
}
