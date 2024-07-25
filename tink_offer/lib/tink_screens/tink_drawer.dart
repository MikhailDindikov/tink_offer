import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tink_offer/tink_screens/tink_system/tink_system.dart';

class TinkDrawer extends StatelessWidget {
  const TinkDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color.fromRGBO(36, 36, 36, 1),
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 270,
            padding:
                const EdgeInsets.only(left: 25, right: 34, top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tink Offer:\nBusiness Assistant!',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(255, 219, 39, 1),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Handle your business tasks in one place',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(245, 247, 248, 0.25),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.to(() => TinkSystem(
                              controllerWT: 'Security Policy',
                            ));
                      },
                      child: Text(
                        'Security Policy',
                        style: TextStyle(
                          fontFamily: 'Sarabun',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(245, 247, 248, 1),
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Color.fromRGBO(142, 142, 147, 0.25),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.to(() => TinkSystem(
                              controllerWT: 'Terms of Use',
                            ));
                      },
                      child: Text(
                        'Terms of Use',
                        style: TextStyle(
                          fontFamily: 'Sarabun',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(245, 247, 248, 1),
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Color.fromRGBO(142, 142, 147, 0.25),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.to(() => TinkSystem(
                              controllerWT: 'Support',
                            ));
                      },
                      child: Text(
                        'Support',
                        style: TextStyle(
                          fontFamily: 'Sarabun',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(245, 247, 248, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Tink Offer: Business\nAssistant! Version 1128.9.0',
                  style: TextStyle(
                    fontFamily: 'Sarabun',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(245, 247, 248, 0.25),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
