import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tink_offer/tink_controllers/tink_profile_controller.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';
import 'package:tink_offer/tink_screens/tink_profile/tink_profile_screen.dart';

AppBar TinkAppBar(GlobalKey<InnerDrawerState> drawerKey) {
  final profileCt = Get.find<TinkProfileController>();
  profileCt.profInit();

  return AppBar(
    elevation: 0,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    title: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.to(() => const TinkProfileScreen());
      },
      child: GetBuilder(
          init: profileCt,
          builder: (context) {
            return Row(
              children: [
                Container(
                  height: profileCt.profPrem ? 46 : 40,
                  width: profileCt.profPrem ? 46 : 40,
                  padding: profileCt.profPrem ? EdgeInsets.all(1) : null,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(24, 24, 24, 1),
                    shape: BoxShape.circle,
                    border: profileCt.profPrem
                        ? Border.all(
                            width: 1.5, color: Color.fromRGBO(255, 219, 39, 1))
                        : null,
                  ),
                  child: profileCt.profImg == null
                      ? Icon(
                          Icons.person,
                          color: Color.fromRGBO(36, 36, 36, 1),
                          size: 20,
                        )
                      : Container(
                          height: 40,
                          width: 40,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Image.memory(
                            profileCt.profImg!,
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${profileCt.profName} ${profileCt.profSurname}',
                  style: TextStyle(
                    fontFamily: 'Sarabun',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(245, 247, 248, 1),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                SvgPicture.asset(
                  'tassets/icons/next.svg',
                  height: 13,
                ),
              ],
            );
          }),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            drawerKey.currentState?.toggle(direction: InnerDrawerDirection.end);
          },
          child: SvgPicture.asset(
            'tassets/icons/drawer.svg',
            height: 20,
          ),
        ),
      ),
    ],
  );
}
