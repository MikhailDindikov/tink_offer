import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:tink_offer/tink_controllers/tink_private_controller.dart';
import 'package:tink_offer/tink_controllers/tink_profile_controller.dart';
import 'package:tink_offer/tink_models/tink_credential_model.dart';
import 'package:tink_offer/tink_models/tink_private_model.dart';
import 'package:tink_offer/tink_screens/dialog_text_field.dart';
import 'package:tink_offer/tink_screens/tink_appbar.dart';
import 'package:tink_offer/tink_screens/tink_calculator/tink_caculator_screen.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';
import 'package:tink_offer/tink_screens/tink_premium/tink_remium_buy.dart';
import 'package:tink_offer/tink_screens/tink_profile/tink_profile_screen.dart';

class TinkPremuimScreen extends StatefulWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  const TinkPremuimScreen({required this.drawerKey, super.key});

  @override
  State<TinkPremuimScreen> createState() => _TinkPremuimScreenState();
}

class _TinkPremuimScreenState extends State<TinkPremuimScreen> {
  final _hasPrem = false;
  final privateCt = Get.find<TinkPrivateController>();
  final profileCt = Get.find<TinkProfileController>();

  void _addData() {
    RxInt tinkType = 1.obs;
    final nameCtP = TextEditingController();
    final noteCtP = TextEditingController();
    final RxBool errorNameP = false.obs;

    RxInt notePLen = 0.obs;

    noteCtP.addListener(() {
      notePLen.value = noteCtP.text.length;
    });

    final nameCtC = TextEditingController();
    final loginCtC = TextEditingController();
    final passCtC = TextEditingController();
    final noteCtC = TextEditingController();
    final RxBool errorNameC = false.obs;
    final RxBool errorLoginC = false.obs;
    final RxBool errorPassC = false.obs;

    RxInt noteCLen = 0.obs;

    noteCtC.addListener(() {
      noteCLen.value = noteCtC.text.length;
    });

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => IntrinsicHeight(
        child: Material(
          color: Color.fromRGBO(24, 24, 24, 0.85),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 75),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(23),
                        child: Builder(builder: (context) {
                          final key = GlobalKey();
                          RxDouble h = 0.0.obs;

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            h.value = key.currentContext!.size!.height;
                          });

                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Obx(
                                () => Container(
                                  height: h.value,
                                  width: 7,
                                  color: const Color.fromRGBO(255, 219, 39, 1),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  key: key,
                                  width: double.infinity,
                                  padding:
                                      EdgeInsets.all(20).copyWith(right: 32),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(36, 36, 36, 1),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          child: Text(
                                            'Let’s create new data:',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily: 'Sarabun',
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  245, 247, 248, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: CustomSlidingSegmentedControl(
                                          innerPadding: EdgeInsets.zero,
                                          padding: 0,
                                          height: 43,
                                          children: {
                                            1: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  top: 8,
                                                  right: 20,
                                                  bottom: 10),
                                              child: Obx(
                                                () => Text(
                                                  'Private Info',
                                                  style: TextStyle(
                                                    fontFamily: 'Sarabun',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: tinkType.value == 1
                                                        ? Color.fromRGBO(
                                                            36, 36, 36, 1)
                                                        : Color.fromRGBO(
                                                            142, 142, 147, 1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            2: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  top: 8,
                                                  right: 20,
                                                  bottom: 10),
                                              child: Obx(
                                                () => Text(
                                                  'Credential',
                                                  style: TextStyle(
                                                    fontFamily: 'Sarabun',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: tinkType.value == 2
                                                        ? Color.fromRGBO(
                                                            36, 36, 36, 1)
                                                        : Color.fromRGBO(
                                                            142, 142, 147, 1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          },
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                142, 142, 147, 0.25),
                                            borderRadius:
                                                BorderRadius.circular(200),
                                          ),
                                          thumbDecoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(255, 219, 39, 1),
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.3),
                                                blurRadius: 4.0,
                                                spreadRadius: 1.0,
                                                offset: Offset(
                                                  0.0,
                                                  2.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeInToLinear,
                                          onValueChanged: (value) {
                                            tinkType.value = value;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Obx(
                                        () => IndexedStack(
                                          index: tinkType.value - 1,
                                          children: [
                                            Column(
                                              children: [
                                                Obx(
                                                  () => DialogTextField(
                                                    leadingIcon:
                                                        SvgPicture.asset(
                                                      'tassets/icons/text_name.svg',
                                                      height: 16,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                    tinkCt: nameCtP,
                                                    isError: errorNameP.value,
                                                    helperText: 'Name',
                                                    tinkIcons: [SizedBox()],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                DialogTextField(
                                                  leadingIcon: SvgPicture.asset(
                                                    'tassets/icons/text_note.svg',
                                                    height: 17,
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                  tinkCt: noteCtP,
                                                  helperText: 'Write new note',
                                                  formatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        500)
                                                  ],
                                                  tinkIcons: [
                                                    Text(
                                                      '${notePLen}/500',
                                                      style: TextStyle(
                                                        fontFamily: 'Sarabun',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            245,
                                                            247,
                                                            248,
                                                            0.25),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Obx(
                                                  () => DialogTextField(
                                                    leadingIcon:
                                                        SvgPicture.asset(
                                                      'tassets/icons/text_name.svg',
                                                      height: 16,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                    tinkCt: nameCtC,
                                                    isError: errorNameC.value,
                                                    helperText: 'Name',
                                                    tinkIcons: [SizedBox()],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  2),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  2),
                                                          topLeft:
                                                              Radius.circular(
                                                                  23),
                                                          topRight:
                                                              Radius.circular(
                                                                  23),
                                                        ),
                                                        color: Color.fromRGBO(
                                                            142,
                                                            142,
                                                            147,
                                                            0.25),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        24,
                                                                    vertical:
                                                                        12)
                                                            .copyWith(
                                                                bottom: 10),
                                                        child: Obx(
                                                          () =>
                                                              DialogDefaultTextField(
                                                            tinkCt: loginCtC,
                                                            isError: errorLoginC
                                                                .value,
                                                            helperText:
                                                                'Write Login/Email',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  23),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  23),
                                                          topLeft:
                                                              Radius.circular(
                                                                  2),
                                                          topRight:
                                                              Radius.circular(
                                                                  2),
                                                        ),
                                                        color: Color.fromRGBO(
                                                            142,
                                                            142,
                                                            147,
                                                            0.25),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        24,
                                                                    vertical:
                                                                        12)
                                                            .copyWith(
                                                                bottom: 10),
                                                        child: Obx(
                                                          () =>
                                                              DialogDefaultTextField(
                                                            tinkCt: passCtC,
                                                            isError: errorPassC
                                                                .value,
                                                            helperText:
                                                                'Write Password',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                DialogTextField(
                                                  leadingIcon: SvgPicture.asset(
                                                    'tassets/icons/text_note.svg',
                                                    height: 17,
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                  tinkCt: noteCtC,
                                                  helperText: 'Add Note',
                                                  formatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        100)
                                                  ],
                                                  tinkIcons: [
                                                    Text(
                                                      '${noteCLen}/100',
                                                      style: TextStyle(
                                                        fontFamily: 'Sarabun',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            245,
                                                            247,
                                                            248,
                                                            0.25),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      IntrinsicWidth(
                                        child: GestureDetector(
                                          onTap: () {
                                            bool isError = false;

                                            if (tinkType.value == 1) {
                                              if (nameCtP.text.isEmpty) {
                                                errorNameP.value = true;
                                                isError = true;
                                              } else {
                                                errorNameP.value = false;
                                              }
                                              if (!isError) {
                                                privateCt.addPrivate(
                                                    TinkPrivateModel(
                                                        id: 0,
                                                        name: nameCtP.text,
                                                        note: noteCtP.text));
                                                Get.back();
                                              }
                                            } else {
                                              if (nameCtC.text.isEmpty) {
                                                errorNameC.value = true;
                                                isError = true;
                                              } else {
                                                errorNameC.value = false;
                                              }
                                              if (loginCtC.text.isEmpty) {
                                                errorLoginC.value = true;
                                                isError = true;
                                              } else {
                                                errorLoginC.value = false;
                                              }
                                              if (passCtC.text.isEmpty) {
                                                errorPassC.value = true;
                                                isError = true;
                                              } else {
                                                errorPassC.value = false;
                                              }
                                              if (!isError) {
                                                privateCt.addCredentail(
                                                    TinkCredentailModel(
                                                        id: 0,
                                                        name: nameCtC.text,
                                                        login: loginCtC.text,
                                                        pass: passCtC.text,
                                                        note: noteCtC.text));
                                                Get.back();
                                              }
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 36),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                              color: Color.fromRGBO(
                                                  255, 219, 39, 1),
                                            ),
                                            child: Text(
                                              'Create',
                                              style: TextStyle(
                                                fontFamily: 'Sarabun',
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    24, 24, 24, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 15,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(36, 36, 36, 1),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'tassets/icons/dial_cross.svg',
                          height: 29,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updatePrivate(TinkPrivateModel tinkPrivateModel) {
    final nameCtP = TextEditingController(text: tinkPrivateModel.name);
    final noteCtP = TextEditingController(text: tinkPrivateModel.note);
    final RxBool errorNameP = false.obs;

    RxInt notePLen = (tinkPrivateModel.note.length).obs;

    noteCtP.addListener(() {
      notePLen.value = noteCtP.text.length;
    });

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => IntrinsicHeight(
        child: Material(
          color: Color.fromRGBO(24, 24, 24, 0.85),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 75),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(23),
                        child: Builder(builder: (context) {
                          final key = GlobalKey();
                          RxDouble h = 0.0.obs;

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            h.value = key.currentContext!.size!.height;
                          });

                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Obx(
                                () => Container(
                                  height: h.value,
                                  width: 7,
                                  color: const Color.fromRGBO(255, 219, 39, 1),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  key: key,
                                  width: double.infinity,
                                  padding:
                                      EdgeInsets.all(20).copyWith(right: 32),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(36, 36, 36, 1),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          child: Text(
                                            'Let’s update data:',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily: 'Sarabun',
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  245, 247, 248, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Column(
                                        children: [
                                          Obx(
                                            () => DialogTextField(
                                              leadingIcon: SvgPicture.asset(
                                                'tassets/icons/text_name.svg',
                                                height: 16,
                                                fit: BoxFit.scaleDown,
                                              ),
                                              tinkCt: nameCtP,
                                              isError: errorNameP.value,
                                              helperText: 'Name',
                                              tinkIcons: [SizedBox()],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          DialogTextField(
                                            leadingIcon: SvgPicture.asset(
                                              'tassets/icons/text_note.svg',
                                              height: 17,
                                              fit: BoxFit.scaleDown,
                                            ),
                                            tinkCt: noteCtP,
                                            helperText: 'Write new note',
                                            formatters: [
                                              LengthLimitingTextInputFormatter(
                                                  500)
                                            ],
                                            tinkIcons: [
                                              Text(
                                                '${notePLen}/500',
                                                style: TextStyle(
                                                  fontFamily: 'Sarabun',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      245, 247, 248, 0.25),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      IntrinsicWidth(
                                        child: GestureDetector(
                                          onTap: () {
                                            bool isError = false;

                                            if (nameCtP.text.isEmpty) {
                                              errorNameP.value = true;
                                              isError = true;
                                            } else {
                                              errorNameP.value = false;
                                            }
                                            if (!isError) {
                                              privateCt.updatePrivate(
                                                  TinkPrivateModel(
                                                      id: tinkPrivateModel.id,
                                                      name: nameCtP.text,
                                                      note: noteCtP.text));
                                              Get.back();
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 36),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                              color: Color.fromRGBO(
                                                  255, 219, 39, 1),
                                            ),
                                            child: Text(
                                              'Update',
                                              style: TextStyle(
                                                fontFamily: 'Sarabun',
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    24, 24, 24, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 15,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(36, 36, 36, 1),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'tassets/icons/dial_cross.svg',
                          height: 29,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateCredential(TinkCredentailModel tinkPrivateModel) {
    final nameCtC = TextEditingController(text: tinkPrivateModel.name);
    final loginCtC = TextEditingController(text: tinkPrivateModel.login);
    final passCtC = TextEditingController(text: tinkPrivateModel.pass);
    final noteCtC = TextEditingController(text: tinkPrivateModel.note);
    final RxBool errorNameC = false.obs;
    final RxBool errorLoginC = false.obs;
    final RxBool errorPassC = false.obs;

    RxInt noteCLen = tinkPrivateModel.note.length.obs;

    noteCtC.addListener(() {
      noteCLen.value = noteCtC.text.length;
    });

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => IntrinsicHeight(
        child: Material(
          color: Color.fromRGBO(24, 24, 24, 0.85),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 75),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(23),
                        child: Builder(builder: (context) {
                          final key = GlobalKey();
                          RxDouble h = 0.0.obs;

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            h.value = key.currentContext!.size!.height;
                          });

                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Obx(
                                () => Container(
                                  height: h.value,
                                  width: 7,
                                  color: const Color.fromRGBO(255, 219, 39, 1),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  key: key,
                                  width: double.infinity,
                                  padding:
                                      EdgeInsets.all(20).copyWith(right: 32),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(36, 36, 36, 1),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          child: Text(
                                            'Let’s create new data:',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily: 'Sarabun',
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  245, 247, 248, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Column(
                                        children: [
                                          Obx(
                                            () => DialogTextField(
                                              leadingIcon: SvgPicture.asset(
                                                'tassets/icons/text_name.svg',
                                                height: 16,
                                                fit: BoxFit.scaleDown,
                                              ),
                                              tinkCt: nameCtC,
                                              isError: errorNameC.value,
                                              helperText: 'Name',
                                              tinkIcons: [SizedBox()],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(2),
                                                    bottomRight:
                                                        Radius.circular(2),
                                                    topLeft:
                                                        Radius.circular(23),
                                                    topRight:
                                                        Radius.circular(23),
                                                  ),
                                                  color: Color.fromRGBO(
                                                      142, 142, 147, 0.25),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                          horizontal: 24,
                                                          vertical: 12)
                                                      .copyWith(bottom: 10),
                                                  child: Obx(
                                                    () =>
                                                        DialogDefaultTextField(
                                                      tinkCt: loginCtC,
                                                      isError:
                                                          errorLoginC.value,
                                                      helperText:
                                                          'Write Login/Email',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(23),
                                                    bottomRight:
                                                        Radius.circular(23),
                                                    topLeft: Radius.circular(2),
                                                    topRight:
                                                        Radius.circular(2),
                                                  ),
                                                  color: Color.fromRGBO(
                                                      142, 142, 147, 0.25),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                          horizontal: 24,
                                                          vertical: 12)
                                                      .copyWith(bottom: 10),
                                                  child: Obx(
                                                    () =>
                                                        DialogDefaultTextField(
                                                      tinkCt: passCtC,
                                                      isError: errorPassC.value,
                                                      helperText:
                                                          'Write Password',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          DialogTextField(
                                            leadingIcon: SvgPicture.asset(
                                              'tassets/icons/text_note.svg',
                                              height: 17,
                                              fit: BoxFit.scaleDown,
                                            ),
                                            tinkCt: noteCtC,
                                            helperText: 'Add Note',
                                            formatters: [
                                              LengthLimitingTextInputFormatter(
                                                  100)
                                            ],
                                            tinkIcons: [
                                              Text(
                                                '${noteCLen}/100',
                                                style: TextStyle(
                                                  fontFamily: 'Sarabun',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      245, 247, 248, 0.25),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      IntrinsicWidth(
                                        child: GestureDetector(
                                          onTap: () {
                                            bool isError = false;

                                            if (nameCtC.text.isEmpty) {
                                              errorNameC.value = true;
                                              isError = true;
                                            } else {
                                              errorNameC.value = false;
                                            }
                                            if (loginCtC.text.isEmpty) {
                                              errorLoginC.value = true;
                                              isError = true;
                                            } else {
                                              errorLoginC.value = false;
                                            }
                                            if (passCtC.text.isEmpty) {
                                              errorPassC.value = true;
                                              isError = true;
                                            } else {
                                              errorPassC.value = false;
                                            }
                                            if (!isError) {
                                              privateCt.updateCredentail(
                                                  TinkCredentailModel(
                                                      id: tinkPrivateModel.id,
                                                      name: nameCtC.text,
                                                      login: loginCtC.text,
                                                      pass: passCtC.text,
                                                      note: noteCtC.text));
                                              Get.back();
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 36),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                              color: Color.fromRGBO(
                                                  255, 219, 39, 1),
                                            ),
                                            child: Text(
                                              'Update',
                                              style: TextStyle(
                                                fontFamily: 'Sarabun',
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    24, 24, 24, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 15,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(36, 36, 36, 1),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'tassets/icons/dial_cross.svg',
                          height: 29,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      privateCt.getAllPrivates();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      appBar: TinkAppBar(widget.drawerKey),
      body: _hasPrem
          ? TinkPremiumBuy()
          : Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Private Data',
                    style: TextStyle(
                      fontFamily: 'Sarabun',
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(245, 247, 248, 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GetBuilder(
                      init: profileCt,
                      builder: (context) {
                        if (!profileCt.profPrem) {
                          return SingleChildScrollView(
                            child: TinkPremiumBuy(),
                          );
                        } else {
                          return Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              GetBuilder(
                                  init: privateCt,
                                  builder: (context) {
                                    if (privateCt.tinkPrivates.isEmpty) {
                                      return SizedBox();
                                    } else {
                                      return ListView.separated(
                                        padding: EdgeInsets.only(bottom: 90),
                                        itemCount:
                                            privateCt.tinkPrivates.length,
                                        itemBuilder: (context, index) =>
                                            privateCt.tinkPrivates[index]
                                                    is TinkCredentailModel
                                                ? TinkCredentialCard(
                                                    tinkCredentialModel:
                                                        privateCt.tinkPrivates[
                                                            index],
                                                    onDelete: () {
                                                      privateCt.deleteCredentail(
                                                          privateCt
                                                                  .tinkPrivates[
                                                              index]);
                                                    },
                                                    onUpdate: () =>
                                                        _updateCredential(
                                                            privateCt
                                                                    .tinkPrivates[
                                                                index]),
                                                  )
                                                : TinkPrivateInfoCard(
                                                    tinkPrivateModel: privateCt
                                                        .tinkPrivates[index],
                                                    onDelete: () {
                                                      privateCt.deletePrivate(
                                                          privateCt
                                                                  .tinkPrivates[
                                                              index]);
                                                    },
                                                    onUpdate: () =>
                                                        _updatePrivate(privateCt
                                                                .tinkPrivates[
                                                            index]),
                                                  ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          height: 7,
                                        ),
                                      );
                                    }
                                  }),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _addData();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 36, vertical: 12.5),
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(255, 219, 39, 1),
                                            borderRadius:
                                                BorderRadius.circular(200),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Create new data',
                                            style: TextStyle(
                                              fontFamily: 'Sarabun',
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color.fromRGBO(24, 24, 24, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }),
                ),
              ],
            ),
    );
  }
}

class TinkCredentialCard extends StatelessWidget {
  final TinkCredentailModel tinkCredentialModel;
  final void Function() onUpdate;
  final void Function() onDelete;
  const TinkCredentialCard(
      {super.key,
      required this.tinkCredentialModel,
      required this.onUpdate,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(36, 36, 36, 1),
            ),
            child: Row(
              children: [
                Container(
                  height: double.infinity,
                  width: 7,
                  color: const Color.fromRGBO(255, 219, 39, 1),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 20,
                      bottom: 30,
                      left: 19,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Credential',
                                    style: TextStyle(
                                      fontFamily: 'Sarabun',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Color.fromRGBO(245, 247, 248, 0.25),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      tinkCredentialModel.name,
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
                            ),
                            Builder(builder: (__) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  showPopover(
                                    context: __,
                                    direction: PopoverDirection.bottom,
                                    radius: 23,
                                    backgroundColor:
                                        const Color.fromRGBO(24, 24, 24, 1),
                                    bodyBuilder: (popoverCtx) => Container(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 7,
                                          left: 15,
                                          right: 20),
                                      child: IntrinsicHeight(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                onUpdate();
                                              },
                                              child: Container(
                                                width: Get.size.width / 2,
                                                margin: const EdgeInsets.only(
                                                    top: 7),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      142, 142, 147, 0.25),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Update',
                                                      style: TextStyle(
                                                        fontFamily: 'Sarabun',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            245, 247, 248, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                onDelete();
                                              },
                                              child: Container(
                                                width: Get.size.width / 2,
                                                margin: const EdgeInsets.only(
                                                    top: 7),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      142, 142, 147, 0.25),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        fontFamily: 'Sarabun',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            245, 247, 248, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: SvgPicture.asset(
                                    'tassets/icons/etc.svg',
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(2),
                                  bottomRight: Radius.circular(2),
                                  topLeft: Radius.circular(23),
                                  topRight: Radius.circular(23),
                                ),
                                color: Color.fromRGBO(142, 142, 147, 0.25),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12)
                                    .copyWith(bottom: 10),
                                child: Text(
                                  tinkCredentialModel.login,
                                  style: TextStyle(
                                    fontFamily: 'Sarabun',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(23),
                                  bottomRight: Radius.circular(23),
                                  topLeft: Radius.circular(2),
                                  topRight: Radius.circular(2),
                                ),
                                color: Color.fromRGBO(142, 142, 147, 0.25),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12)
                                    .copyWith(bottom: 10),
                                child: Text(
                                  tinkCredentialModel.pass,
                                  style: TextStyle(
                                    fontFamily: 'Sarabun',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                tinkCredentialModel.note,
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(142, 142, 147, 1),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ],
                    ),
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

class TinkPrivateInfoCard extends StatelessWidget {
  final TinkPrivateModel tinkPrivateModel;
  final void Function() onUpdate;
  final void Function() onDelete;
  const TinkPrivateInfoCard(
      {super.key,
      required this.tinkPrivateModel,
      required this.onUpdate,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(36, 36, 36, 1),
            ),
            child: Row(
              children: [
                Container(
                  height: double.infinity,
                  width: 7,
                  color: const Color.fromRGBO(255, 219, 39, 1),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 20,
                      bottom: 30,
                      left: 19,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Private Info',
                                    style: TextStyle(
                                      fontFamily: 'Sarabun',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Color.fromRGBO(245, 247, 248, 0.25),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      tinkPrivateModel.name,
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
                            ),
                            Builder(builder: (__) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  showPopover(
                                    context: __,
                                    direction: PopoverDirection.bottom,
                                    radius: 23,
                                    backgroundColor:
                                        const Color.fromRGBO(24, 24, 24, 1),
                                    bodyBuilder: (popoverCtx) => Container(
                                      padding: const EdgeInsets.only(
                                          top: 0,
                                          bottom: 7,
                                          left: 15,
                                          right: 20),
                                      child: IntrinsicHeight(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                onUpdate();
                                              },
                                              child: Container(
                                                width: Get.size.width / 2,
                                                margin: const EdgeInsets.only(
                                                    top: 7),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      142, 142, 147, 0.25),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Update',
                                                      style: TextStyle(
                                                        fontFamily: 'Sarabun',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            245, 247, 248, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                onDelete();
                                              },
                                              child: Container(
                                                width: Get.size.width / 2,
                                                margin: const EdgeInsets.only(
                                                    top: 7),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      142, 142, 147, 0.25),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        fontFamily: 'Sarabun',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            245, 247, 248, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: SvgPicture.asset(
                                    'tassets/icons/etc.svg',
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          tinkPrivateModel.note,
                          style: TextStyle(
                            fontFamily: 'Sarabun',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(245, 247, 248, 1),
                          ),
                        ),
                      ],
                    ),
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
