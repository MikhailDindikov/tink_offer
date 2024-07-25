import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:tink_offer/formatters/date_formatter.dart';
import 'package:tink_offer/formatters/time_formatter.dart';
import 'package:tink_offer/tink_controllers/tink_cases_controller.dart';
import 'package:tink_offer/tink_controllers/tink_events_controller.dart';
import 'package:tink_offer/tink_models/tink_event_model.dart';
import 'package:tink_offer/tink_screens/dialog_text_field.dart';
import 'package:tink_offer/tink_screens/tink_appbar.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';
import 'package:tink_offer/tink_screens/tink_profile/tink_profile_screen.dart';

class TinkEvents extends StatefulWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  const TinkEvents({required this.drawerKey, super.key});

  @override
  State<TinkEvents> createState() => _TinkEventsState();
}

class _TinkEventsState extends State<TinkEvents> {
  final orderFilters = ['The latest', 'The newest'];
  final eventsType = [
    'Tender',
    'Business meeting',
    'Personal meeting',
    'Assembly',
    'Other'
  ];
  final monthFilters = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final eventsCt = Get.find<TinkEventsController>();
  final casesCt = Get.find<TinkCasesController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventsCt.getEvents();
    });
  }

  void _addEvent() {
    final RxBool errorName = false.obs;
    final RxBool errorType = false.obs;
    final RxBool errorDate = false.obs;
    final RxBool errorTime = false.obs;
    final nameCt = TextEditingController();
    final typeCt = TextEditingController();
    final infoCt = TextEditingController();
    final dateCt = TextEditingController();
    final timeCt = TextEditingController();
    final remindCt = TextEditingController();
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => IntrinsicHeight(
        child: Material(
          color: const Color.fromRGBO(24, 24, 24, 0.85),
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
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(23),
                          child: Row(
                            children: [
                              Container(
                                height: double.infinity,
                                width: 7,
                                color: const Color.fromRGBO(255, 219, 39, 1),
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20)
                                      .copyWith(right: 32),
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(36, 36, 36, 1),
                                  ),
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          child: Text(
                                            'Let’s create new payment:',
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
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Obx(
                                        () => DialogTextField(
                                          leadingIcon: SvgPicture.asset(
                                            'tassets/icons/text_name.svg',
                                            height: 16,
                                            fit: BoxFit.scaleDown,
                                          ),
                                          isError: errorName.value,
                                          tinkCt: nameCt,
                                          helperText: 'Name (purpose)',
                                          tinkIcons: [const SizedBox()],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Builder(builder: (__) {
                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            showPopover(
                                              context: __,
                                              direction:
                                                  PopoverDirection.bottom,
                                              radius: 23,
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      24, 24, 24, 1),
                                              bodyBuilder: (popoverCtx) =>
                                                  Container(
                                                padding: const EdgeInsets.only(
                                                    top: 0,
                                                    bottom: 7,
                                                    left: 15,
                                                    right: 20),
                                                child: IntrinsicHeight(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List.generate(
                                                      eventsType.length,
                                                      (index) =>
                                                          GestureDetector(
                                                        onTap: () {
                                                          typeCt.text =
                                                              eventsType[index];
                                                          Get.back();
                                                        },
                                                        child: Container(
                                                          width:
                                                              Get.size.width /
                                                                  2,
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(top: 7),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color
                                                                .fromRGBO(142,
                                                                142, 147, 0.25),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                eventsType[
                                                                    index],
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      'Sarabun',
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          245,
                                                                          247,
                                                                          248,
                                                                          1),
                                                                ),
                                                              ),
                                                              eventsType[index] ==
                                                                      typeCt
                                                                          .text
                                                                  ? const Icon(
                                                                      Icons
                                                                          .done,
                                                                      color: Colors
                                                                          .white,
                                                                    )
                                                                  : const SizedBox(),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: SizedBox(
                                            child: Obx(
                                              () => IgnorePointer(
                                                child: DialogTextField(
                                                  leadingIcon: SvgPicture.asset(
                                                    'tassets/icons/text_type.svg',
                                                    height: 12,
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                  isError: errorType.value,
                                                  tinkCt: typeCt,
                                                  helperText: 'Type',
                                                  tinkIcons: [
                                                    SvgPicture.asset(
                                                        'tassets/icons/bbottom.svg')
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      DialogTextField(
                                        leadingIcon: SvgPicture.asset(
                                          'tassets/icons/text_info.svg',
                                          height: 15,
                                          fit: BoxFit.scaleDown,
                                        ),
                                        tinkCt: infoCt,
                                        helperText: 'Little information',
                                        tinkIcons: [const SizedBox()],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Obx(
                                        () => DialogTextField(
                                          leadingIcon: SvgPicture.asset(
                                            'tassets/icons/text_date.svg',
                                            height: 17,
                                            fit: BoxFit.scaleDown,
                                          ),
                                          tinkCt: dateCt,
                                          formatters: [
                                            DateTextFormatter(),
                                          ],
                                          isError: errorDate.value,
                                          helperText: 'Date',
                                          tinkIcons: [const SizedBox()],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Obx(
                                        () => DialogTextField(
                                          leadingIcon: SvgPicture.asset(
                                            'tassets/icons/text_time.svg',
                                            height: 18,
                                            fit: BoxFit.scaleDown,
                                          ),
                                          tinkCt: timeCt,
                                          isError: errorTime.value,
                                          helperText: 'Time',
                                          formatters: [
                                            TimeTextFormatter(),
                                          ],
                                          tinkIcons: [const SizedBox()],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      DialogTextField(
                                        leadingIcon: SvgPicture.asset(
                                          'tassets/icons/text_remind.svg',
                                          height: 19,
                                          fit: BoxFit.scaleDown,
                                        ),
                                        tinkCt: remindCt,
                                        formatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
                                        ],
                                        helperText: 'Remind in ... days',
                                        tinkIcons: [const SizedBox()],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      IntrinsicWidth(
                                        child: GestureDetector(
                                          onTap: () {
                                            bool isError = false;

                                            if (nameCt.text.isEmpty) {
                                              errorName.value = true;
                                              isError = true;
                                            } else {
                                              errorName.value = false;
                                            }
                                            if (typeCt.text.isEmpty) {
                                              errorType.value = true;
                                              isError = true;
                                            } else {
                                              errorType.value = false;
                                            }

                                            if (dateCt.text.isEmpty ||
                                                dateCt.text.length != 10) {
                                              errorDate.value = true;
                                              isError = true;
                                            } else {
                                              errorDate.value = false;
                                            }
                                            if (timeCt.text.isEmpty ||
                                                timeCt.text.length != 5) {
                                              errorTime.value = true;
                                              isError = true;
                                            } else {
                                              errorTime.value = false;
                                            }
                                            if (!isError) {
                                              eventsCt.addEvent(TinkEventModel(
                                                  id: 0,
                                                  name: nameCt.text,
                                                  type: typeCt.text,
                                                  info: infoCt.text,
                                                  day:
                                                      dateCt.text.split('.')[0],
                                                  month:
                                                      dateCt.text.split('.')[1],
                                                  year:
                                                      dateCt.text.split('.')[2],
                                                  time: timeCt.text,
                                                  remind: remindCt.text));
                                              casesCt.getAllCases();
                                              casesCt.getAllCasesDates();
                                              Get.back();
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 36),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                              color: const Color.fromRGBO(
                                                  255, 219, 39, 1),
                                            ),
                                            child: const Text(
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
                          ),
                        ),
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
                        decoration: const BoxDecoration(
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

  void _updateEvent(TinkEventModel tinkPaymentModel) {
    final RxBool errorName = false.obs;
    final RxBool errorType = false.obs;
    final RxBool errorDate = false.obs;
    final RxBool errorTime = false.obs;
    final nameCt = TextEditingController(text: tinkPaymentModel.name);
    final typeCt = TextEditingController(text: tinkPaymentModel.type);
    final infoCt = TextEditingController(text: tinkPaymentModel.info);
    final dateCt = TextEditingController(
        text:
            '${tinkPaymentModel.day}.${tinkPaymentModel.month}.${tinkPaymentModel.year}');
    final timeCt = TextEditingController(text: tinkPaymentModel.time);
    final remindCt = TextEditingController(text: tinkPaymentModel.remind);
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => IntrinsicHeight(
        child: Material(
          color: const Color.fromRGBO(24, 24, 24, 0.85),
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
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(23),
                          child: Row(
                            children: [
                              Container(
                                height: double.infinity,
                                width: 7,
                                color: const Color.fromRGBO(255, 219, 39, 1),
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20)
                                      .copyWith(right: 32),
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(36, 36, 36, 1),
                                  ),
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          child: Text(
                                            'Let’s update event:',
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
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Obx(
                                        () => DialogTextField(
                                          leadingIcon: SvgPicture.asset(
                                            'tassets/icons/text_name.svg',
                                            height: 16,
                                            fit: BoxFit.scaleDown,
                                          ),
                                          tinkCt: nameCt,
                                          isError: errorName.value,
                                          helperText: 'Name (purpose)',
                                          tinkIcons: [const SizedBox()],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Builder(builder: (__) {
                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            showPopover(
                                              context: __,
                                              direction:
                                                  PopoverDirection.bottom,
                                              radius: 23,
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      24, 24, 24, 1),
                                              bodyBuilder: (popoverCtx) =>
                                                  Container(
                                                padding: const EdgeInsets.only(
                                                    top: 0,
                                                    bottom: 7,
                                                    left: 15,
                                                    right: 20),
                                                child: IntrinsicHeight(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List.generate(
                                                      eventsType.length,
                                                      (index) =>
                                                          GestureDetector(
                                                        onTap: () {
                                                          typeCt.text =
                                                              eventsType[index];
                                                          Get.back();
                                                        },
                                                        child: Container(
                                                          width:
                                                              Get.size.width /
                                                                  2,
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(top: 7),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color
                                                                .fromRGBO(142,
                                                                142, 147, 0.25),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                eventsType[
                                                                    index],
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      'Sarabun',
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          245,
                                                                          247,
                                                                          248,
                                                                          1),
                                                                ),
                                                              ),
                                                              eventsType[index] ==
                                                                      typeCt
                                                                          .text
                                                                  ? const Icon(
                                                                      Icons
                                                                          .done,
                                                                      color: Colors
                                                                          .white,
                                                                    )
                                                                  : const SizedBox(),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: SizedBox(
                                            child: Obx(
                                              () => IgnorePointer(
                                                child: DialogTextField(
                                                  leadingIcon: SvgPicture.asset(
                                                    'tassets/icons/text_type.svg',
                                                    height: 12,
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                  isError: errorType.value,
                                                  tinkCt: typeCt,
                                                  helperText: 'Type',
                                                  tinkIcons: [
                                                    SvgPicture.asset(
                                                        'tassets/icons/bbottom.svg')
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      DialogTextField(
                                        leadingIcon: SvgPicture.asset(
                                          'tassets/icons/text_info.svg',
                                          height: 15,
                                          fit: BoxFit.scaleDown,
                                        ),
                                        tinkCt: infoCt,
                                        helperText: 'Little information',
                                        tinkIcons: [const SizedBox()],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Obx(
                                        () => DialogTextField(
                                          leadingIcon: SvgPicture.asset(
                                            'tassets/icons/text_date.svg',
                                            height: 17,
                                            fit: BoxFit.scaleDown,
                                          ),
                                          tinkCt: dateCt,
                                          isError: errorDate.value,
                                          formatters: [
                                            DateTextFormatter(),
                                          ],
                                          helperText: 'Date',
                                          tinkIcons: [const SizedBox()],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Obx(
                                        () => DialogTextField(
                                          leadingIcon: SvgPicture.asset(
                                            'tassets/icons/text_time.svg',
                                            height: 18,
                                            fit: BoxFit.scaleDown,
                                          ),
                                          tinkCt: timeCt,
                                          isError: errorTime.value,
                                          formatters: [
                                            TimeTextFormatter(),
                                          ],
                                          helperText: 'Time',
                                          tinkIcons: [const SizedBox()],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      DialogTextField(
                                        leadingIcon: SvgPicture.asset(
                                          'tassets/icons/text_remind.svg',
                                          height: 19,
                                          fit: BoxFit.scaleDown,
                                        ),
                                        tinkCt: remindCt,
                                        formatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
                                        ],
                                        helperText: 'Remind in ... days',
                                        tinkIcons: [const SizedBox()],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      IntrinsicWidth(
                                        child: GestureDetector(
                                          onTap: () {
                                            bool isError = false;

                                            if (nameCt.text.isEmpty) {
                                              errorName.value = true;
                                              isError = true;
                                            } else {
                                              errorName.value = false;
                                            }
                                            if (typeCt.text.isEmpty) {
                                              errorType.value = true;
                                              isError = true;
                                            } else {
                                              errorType.value = false;
                                            }
                                            if (dateCt.text.isEmpty ||
                                                dateCt.text.length != 10) {
                                              errorDate.value = true;
                                              isError = true;
                                            } else {
                                              errorDate.value = false;
                                            }
                                            if (timeCt.text.isEmpty ||
                                                timeCt.text.length != 5) {
                                              errorTime.value = true;
                                              isError = true;
                                            } else {
                                              errorTime.value = false;
                                            }
                                            if (!isError) {
                                              eventsCt.updateEvent(
                                                  TinkEventModel(
                                                      id: tinkPaymentModel.id,
                                                      name: nameCt.text,
                                                      type: typeCt.text,
                                                      info: infoCt.text,
                                                      day: dateCt.text
                                                          .split('.')[0],
                                                      month: dateCt.text
                                                          .split('.')[1],
                                                      year: dateCt.text
                                                          .split('.')[2],
                                                      time: timeCt.text,
                                                      remind: remindCt.text));
                                              casesCt.getAllCases();
                                              casesCt.getAllCasesDates();
                                              Get.back();
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 36),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                              color: const Color.fromRGBO(
                                                  255, 219, 39, 1),
                                            ),
                                            child: const Text(
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
                          ),
                        ),
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
                        decoration: const BoxDecoration(
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      appBar: TinkAppBar(widget.drawerKey),  body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Events',
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
          IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Builder(builder: (__) {
                      return GestureDetector(
                        onTap: () {
                          showPopover(
                            context: __,
                            direction: PopoverDirection.bottom,
                            radius: 23,
                            backgroundColor:
                                const Color.fromRGBO(24, 24, 24, 1),
                            bodyBuilder: (popoverCtx) => Container(
                              padding: const EdgeInsets.only(
                                  top: 0, bottom: 7, left: 15, right: 20),
                              child: IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    orderFilters.length,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        eventsCt.orderType.value = index;
                                        eventsCt.sortDate();
                                        Get.back();
                                      },
                                      child: Container(
                                        width: Get.size.width / 2,
                                        margin: const EdgeInsets.only(top: 7),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              142, 142, 147, 0.25),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              orderFilters[index],
                                              style: const TextStyle(
                                                fontFamily: 'Sarabun',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(
                                                    245, 247, 248, 1),
                                              ),
                                            ),
                                            Obx(
                                              () => index ==
                                                      eventsCt.orderType.value
                                                  ? const Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                    )
                                                  : const SizedBox(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 7, bottom: 7, left: 15, right: 20),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(142, 142, 147, 0.25),
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => Text(
                                  orderFilters[eventsCt.orderType.value],
                                  style: const TextStyle(
                                    fontFamily: 'Sarabun',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(245, 247, 248, 1),
                                  ),
                                ),
                              ),
                              SvgPicture.asset('tassets/icons/bottom.svg'),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Builder(builder: (__) {
                      return GestureDetector(
                        onTap: () {
                          showPopover(
                            context: __,
                            direction: PopoverDirection.bottom,
                            radius: 23,
                            height: 200,
                            backgroundColor:
                                const Color.fromRGBO(24, 24, 24, 1),
                            bodyBuilder: (popoverCtx) => Container(
                              padding: const EdgeInsets.only(
                                  top: 0, bottom: 7, left: 15, right: 20),
                              child: IntrinsicHeight(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      monthFilters.length,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          eventsCt.selMonth.value = index + 1;
                                          eventsCt.getEvents();
                                          Get.back();
                                        },
                                        child: Container(
                                          width: Get.size.width / 2,
                                          margin: const EdgeInsets.only(top: 7),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                142, 142, 147, 0.25),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                monthFilters[index],
                                                style: const TextStyle(
                                                  fontFamily: 'Sarabun',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      245, 247, 248, 1),
                                                ),
                                              ),
                                              Obx(
                                                () => index ==
                                                        eventsCt.selMonth
                                                                .value -
                                                            1
                                                    ? const Icon(
                                                        Icons.done,
                                                        color: Colors.white,
                                                      )
                                                    : const SizedBox(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.only(
                              top: 7, bottom: 7, left: 15, right: 20),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(142, 142, 147, 0.25),
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => Text(
                                  monthFilters[eventsCt.selMonth.value - 1],
                                  style: TextStyle(
                                    fontFamily: 'Sarabun',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(245, 247, 248, 1),
                                  ),
                                ),
                              ),
                              SvgPicture.asset('tassets/icons/bottom.svg'),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GetBuilder(
                    init: eventsCt,
                    builder: (_) {
                      if (eventsCt.tinkEvents.isEmpty) {
                        return const SizedBox();
                      } else {
                        return ListView.separated(
                          padding: EdgeInsets.only(bottom: 90),
                          itemCount: eventsCt.tinkEvents.length,
                          itemBuilder: (context, index) => TinkEventCard(
                            tinkEventModel: eventsCt.tinkEvents[index],
                            onUpdate: () =>
                                _updateEvent(eventsCt.tinkEvents[index]),
                            onDelete: () {
                              eventsCt.deleteEvent(eventsCt.tinkEvents[index]);
                              casesCt.getAllCases();
                              casesCt.getAllCasesDates();
                            },
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
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
                            _addEvent();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 36, vertical: 12.5),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 219, 39, 1),
                              borderRadius: BorderRadius.circular(200),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Create new event',
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(24, 24, 24, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TinkEventCard extends StatelessWidget {
  final TinkEventModel tinkEventModel;
  final void Function() onUpdate;
  final void Function() onDelete;
  const TinkEventCard(
      {required this.tinkEventModel,
      required this.onUpdate,
      required this.onDelete,
      super.key});

  Color get _tinkColor {
    switch (tinkEventModel.type) {
      case 'Tender':
        return Color.fromRGBO(29, 48, 255, 1);
      case 'Business meeting':
        return Color.fromRGBO(151, 71, 255, 1);
      case 'Personal meeting':
        return Color.fromRGBO(246, 0, 255, 1);
      case 'Assembly':
        return Color.fromRGBO(5, 231, 167, 1);
      case 'Other':
        return Color.fromRGBO(142, 142, 147, 0.25);
      default:
        return Color.fromRGBO(36, 36, 36, 1);
    }
  }

  String get _tinkMonth {
    switch (tinkEventModel.month) {
      case '01':
        return 'January';
      case '02':
        return 'February';
      case '03':
        return 'March';
      case '04':
        return 'April';
      case '05':
        return 'May';
      case '06':
        return 'June';
      case '07':
        return 'July';
      case '08':
        return 'August';
      case '09':
        return 'September';
      case '10':
        return 'October';
      case '11':
        return 'November';
      case '12':
        return 'December';
      default:
        return '';
    }
  }

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
                  color: _tinkColor,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Event',
                                  style: TextStyle(
                                    fontFamily: 'Sarabun',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(245, 247, 248, 0.25),
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
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 7),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromRGBO(
                                                              142,
                                                              142,
                                                              147,
                                                              0.25),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Update',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Sarabun',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromRGBO(
                                                                    245,
                                                                    247,
                                                                    248,
                                                                    1),
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
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 7),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromRGBO(
                                                              142,
                                                              142,
                                                              147,
                                                              0.25),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Sarabun',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromRGBO(
                                                                    245,
                                                                    247,
                                                                    248,
                                                                    1),
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
                              child: Text(
                                tinkEventModel.name,
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
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                tinkEventModel.info,
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
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: _tinkColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              tinkEventModel.type,
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(142, 142, 147, 1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(142, 142, 147, 0.25),
                                borderRadius: BorderRadius.circular(200),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${tinkEventModel.day} $_tinkMonth ${tinkEventModel.year}',
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(245, 247, 248, 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(142, 142, 147, 0.25),
                                borderRadius: BorderRadius.circular(200),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                tinkEventModel.time,
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(245, 247, 248, 1),
                                ),
                              ),
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
