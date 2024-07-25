import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tink_offer/tink_screens/tink_calculator/tink_caculator_screen.dart';
import 'package:tink_offer/tink_screens/tink_calculator/tink_credit_detail.dart';
import 'package:tink_offer/tink_screens/tink_calculator/tink_deposit_detail.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';

class TinkCalculatorNavigator extends StatelessWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  const TinkCalculatorNavigator({required this.drawerKey, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Navigator(
        key: Get.nestedKey(4),
        initialRoute: '/calculator',
        observers: [HeroController()],
        onGenerateRoute: (settings) {
          if (settings.name == '/calculator') {
            return GetPageRoute<dynamic>(
              page: () => TinkCalculatorScreen(
                drawerKey: drawerKey,
              ),
            );
          } else if (settings.name == '/calculator/credit_detal') {
            return GetPageRoute<dynamic>(
              page: () => TinkCreditDetail(
                drawerKey: drawerKey,
                allSum: int.parse(
                    (settings.arguments! as Map<String, dynamic>)['allSum']
                        .toString()),
                percent: double.parse(
                    (settings.arguments! as Map<String, dynamic>)['percent']
                        .toString()),
                months: int.parse(
                    (settings.arguments! as Map<String, dynamic>)['months']
                        .toString()),
              ),
            );
          } else if (settings.name == '/calculator/deposit_detal') {
            return GetPageRoute<dynamic>(
              page: () => TinkDepositDetail(
                drawerKey: drawerKey,
                isYear: bool.parse(
                    (settings.arguments! as Map<String, dynamic>)['isYear']
                        .toString()),
                deposit: int.parse(
                    (settings.arguments! as Map<String, dynamic>)['deposit']
                        .toString()),
                months: int.parse(
                    (settings.arguments! as Map<String, dynamic>)['months']
                        .toString()),
                percents: double.parse(
                    (settings.arguments! as Map<String, dynamic>)['percent']
                        .toString()),
              ),
            );
          }
          return null;
        },
      );
}
