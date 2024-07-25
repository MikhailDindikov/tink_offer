import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:popover/popover.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tink_offer/formatters/date_formatter.dart';
import 'package:tink_offer/formatters/time_formatter.dart';
import 'package:tink_offer/tink_controllers/tink_cases_controller.dart';
import 'package:tink_offer/tink_controllers/tink_events_controller.dart';
import 'package:tink_offer/tink_controllers/tink_payments_controller.dart';
import 'package:tink_offer/tink_controllers/tink_summary_controller.dart';
import 'package:tink_offer/tink_models/tink_event_model.dart';
import 'package:tink_offer/tink_models/tink_payment_model.dart';
import 'package:tink_offer/tink_screens/dialog_text_field.dart';
import 'package:tink_offer/tink_screens/tink_appbar.dart';
import 'package:tink_offer/tink_screens/tink_calculator/tink_caculator_screen.dart';
import 'package:tink_offer/tink_screens/tink_calendar/tink_calendar_empty.dart';
import 'package:tink_offer/tink_screens/tink_events.dart/tink_events.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';
import 'package:tink_offer/tink_screens/tink_payments/tink_payments.dart';
import 'package:tink_offer/tink_screens/tink_profile/tink_profile_screen.dart';

class TinkCalendarScreen extends StatefulWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  const TinkCalendarScreen({required this.drawerKey, super.key});

  @override
  State<TinkCalendarScreen> createState() => _TinkCalendarScreenState();
}

class _TinkCalendarScreenState extends State<TinkCalendarScreen> {
  final summaryCt = Get.find<TinkSummaryController>();
  final casesCt = Get.find<TinkCasesController>();
  final paymentsCt = Get.find<TinkPaymentsController>();
  final eventsCt = Get.find<TinkEventsController>();
  final paymentsType = ['Rent', 'Credit', 'Another', 'Salary'];
  final eventsType = [
    'Tender',
    'Business meeting',
    'Personal meeting',
    'Assembly',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      casesCt.getAllCasesDates();
      casesCt.getAllCases();
    });
  }

  void _addCase() {
    RxInt tinkType = 1.obs;
    final RxBool errorName = false.obs;
    final RxBool errorType = false.obs;
    final RxBool errorAmount = false.obs;
    final RxBool errorDate = false.obs;
    final RxBool errorTime = false.obs;
    final nameCtP = TextEditingController();
    final typeCtP = TextEditingController();
    final amountCtP = TextEditingController();
    final infoCtP = TextEditingController();
    final dateCtP = TextEditingController();
    final timeCtP = TextEditingController();
    final remindCtP = TextEditingController();

    final RxBool errorNameE = false.obs;
    final RxBool errorTypeE = false.obs;
    final RxBool errorDateE = false.obs;
    final RxBool errorTimeE = false.obs;
    final nameCtE = TextEditingController();
    final typeCtE = TextEditingController();
    final infoCtE = TextEditingController();
    final dateCtE = TextEditingController();
    final timeCtE = TextEditingController();
    final remindCtE = TextEditingController();

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
                                            'Let’s create new case:',
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
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: CustomSlidingSegmentedControl(
                                          innerPadding: EdgeInsets.zero,
                                          padding: 0,
                                          height: 43,
                                          children: {
                                            1: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  top: 8,
                                                  right: 20,
                                                  bottom: 10),
                                              child: Obx(
                                                () => Text(
                                                  'Payment',
                                                  style: TextStyle(
                                                    fontFamily: 'Sarabun',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: tinkType.value == 1
                                                        ? const Color.fromRGBO(
                                                            36, 36, 36, 1)
                                                        : const Color.fromRGBO(
                                                            142, 142, 147, 1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            2: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  top: 8,
                                                  right: 20,
                                                  bottom: 10),
                                              child: Obx(
                                                () => Text(
                                                  'Event',
                                                  style: TextStyle(
                                                    fontFamily: 'Sarabun',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: tinkType.value == 2
                                                        ? const Color.fromRGBO(
                                                            36, 36, 36, 1)
                                                        : const Color.fromRGBO(
                                                            142, 142, 147, 1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          },
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                142, 142, 147, 0.25),
                                            borderRadius:
                                                BorderRadius.circular(200),
                                          ),
                                          thumbDecoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                255, 219, 39, 1),
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.3),
                                                blurRadius: 4.0,
                                                spreadRadius: 1.0,
                                                offset: const Offset(
                                                  0.0,
                                                  2.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInToLinear,
                                          onValueChanged: (value) {
                                            tinkType.value = value;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
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
                                                    isError: errorName.value,
                                                    helperText:
                                                        'Name (purpose)',
                                                    tinkIcons: [
                                                      const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Builder(builder: (__) {
                                                  return GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () {
                                                      showPopover(
                                                        context: __,
                                                        direction:
                                                            PopoverDirection
                                                                .bottom,
                                                        radius: 23,
                                                        backgroundColor:
                                                            const Color
                                                                .fromRGBO(
                                                                24, 24, 24, 1),
                                                        bodyBuilder:
                                                            (popoverCtx) =>
                                                                Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 0,
                                                                  bottom: 7,
                                                                  left: 15,
                                                                  right: 20),
                                                          child:
                                                              IntrinsicHeight(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children:
                                                                  List.generate(
                                                                paymentsType
                                                                    .length,
                                                                (index) =>
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    typeCtP.text =
                                                                        paymentsType[
                                                                            index];
                                                                    Get.back();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: Get
                                                                            .size
                                                                            .width /
                                                                        2,
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        top: 7),
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          142,
                                                                          142,
                                                                          147,
                                                                          0.25),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          paymentsType[
                                                                              index],
                                                                          style:
                                                                              const TextStyle(
                                                                            fontFamily:
                                                                                'Sarabun',
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: Color.fromRGBO(
                                                                                245,
                                                                                247,
                                                                                248,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                        paymentsType[index] ==
                                                                                typeCtP.text
                                                                            ? const Icon(
                                                                                Icons.done,
                                                                                color: Colors.white,
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
                                                          child:
                                                              DialogTextField(
                                                            leadingIcon:
                                                                SvgPicture
                                                                    .asset(
                                                              'tassets/icons/text_type.svg',
                                                              height: 12,
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                            ),
                                                            isError:
                                                                errorType.value,
                                                            tinkCt: typeCtP,
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
                                                Obx(
                                                  () => DialogTextField(
                                                    leadingIcon:
                                                        SvgPicture.asset(
                                                      'tassets/icons/text_amount.svg',
                                                      height: 15,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                    tinkCt: amountCtP,
                                                    isError: errorAmount.value,
                                                    helperText: 'Amount, \$',
                                                    formatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp(r'[0-9]')),
                                                    ],
                                                    tinkIcons: [
                                                      const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                DialogTextField(
                                                  leadingIcon: SvgPicture.asset(
                                                    'tassets/icons/text_info.svg',
                                                    height: 15,
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                  tinkCt: infoCtP,
                                                  helperText:
                                                      'Little information',
                                                  tinkIcons: [const SizedBox()],
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Obx(
                                                  () => DialogTextField(
                                                    leadingIcon:
                                                        SvgPicture.asset(
                                                      'tassets/icons/text_date.svg',
                                                      height: 17,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                    tinkCt: dateCtP,
                                                    isError: errorDate.value,
                                                    helperText: 'Date',
                                                    formatters: [
                                                      DateTextFormatter(),
                                                    ],
                                                    tinkIcons: [
                                                      const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Obx(
                                                  () => DialogTextField(
                                                    leadingIcon:
                                                        SvgPicture.asset(
                                                      'tassets/icons/text_time.svg',
                                                      height: 18,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                    tinkCt: timeCtP,
                                                    isError: errorTime.value,
                                                    helperText: 'Time',
                                                    formatters: [
                                                      TimeTextFormatter(),
                                                    ],
                                                    tinkIcons: [
                                                      const SizedBox()
                                                    ],
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
                                                  tinkCt: remindCtP,
                                                  formatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                  ],
                                                  helperText:
                                                      'Remind in ... days',
                                                  tinkIcons: [const SizedBox()],
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
                                                    tinkCt: nameCtE,
                                                    isError: errorNameE.value,
                                                    helperText:
                                                        'Name (purpose)',
                                                    tinkIcons: [
                                                      const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Builder(builder: (__) {
                                                  return GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () {
                                                      showPopover(
                                                        context: __,
                                                        direction:
                                                            PopoverDirection
                                                                .bottom,
                                                        radius: 23,
                                                        backgroundColor:
                                                            const Color
                                                                .fromRGBO(
                                                                24, 24, 24, 1),
                                                        bodyBuilder:
                                                            (popoverCtx) =>
                                                                Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 0,
                                                                  bottom: 7,
                                                                  left: 15,
                                                                  right: 20),
                                                          child:
                                                              IntrinsicHeight(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children:
                                                                  List.generate(
                                                                eventsType
                                                                    .length,
                                                                (index) =>
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    typeCtE.text =
                                                                        eventsType[
                                                                            index];
                                                                    Get.back();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: Get
                                                                            .size
                                                                            .width /
                                                                        2,
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        top: 7),
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: const Color
                                                                          .fromRGBO(
                                                                          142,
                                                                          142,
                                                                          147,
                                                                          0.25),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
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
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: Color.fromRGBO(
                                                                                245,
                                                                                247,
                                                                                248,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                        eventsType[index] ==
                                                                                typeCtE.text
                                                                            ? const Icon(
                                                                                Icons.done,
                                                                                color: Colors.white,
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
                                                          child:
                                                              DialogTextField(
                                                            leadingIcon:
                                                                SvgPicture
                                                                    .asset(
                                                              'tassets/icons/text_type.svg',
                                                              height: 12,
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                            ),
                                                            isError:
                                                                errorType.value,
                                                            tinkCt: typeCtE,
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
                                                  tinkCt: infoCtE,
                                                  helperText:
                                                      'Little information',
                                                  tinkIcons: [const SizedBox()],
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Obx(
                                                  () => DialogTextField(
                                                    leadingIcon:
                                                        SvgPicture.asset(
                                                      'tassets/icons/text_date.svg',
                                                      height: 17,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                    tinkCt: dateCtE,
                                                    isError: errorDateE.value,
                                                    helperText: 'Date',
                                                    formatters: [
                                                      DateTextFormatter(),
                                                    ],
                                                    tinkIcons: [
                                                      const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Obx(
                                                  () => DialogTextField(
                                                    leadingIcon:
                                                        SvgPicture.asset(
                                                      'tassets/icons/text_time.svg',
                                                      height: 18,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                    tinkCt: timeCtE,
                                                    formatters: [
                                                      TimeTextFormatter(),
                                                    ],
                                                    isError: errorTimeE.value,
                                                    helperText: 'Time',
                                                    tinkIcons: [
                                                      const SizedBox()
                                                    ],
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
                                                  tinkCt: remindCtE,
                                                  formatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                  ],
                                                  helperText:
                                                      'Remind in ... days',
                                                  tinkIcons: [const SizedBox()],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      IntrinsicWidth(
                                        child: GestureDetector(
                                          onTap: () {
                                            bool isError = false;

                                            if (tinkType.value == 1) {
                                              if (nameCtP.text.isEmpty) {
                                                errorName.value = true;
                                                isError = true;
                                              } else {
                                                errorName.value = false;
                                              }
                                              if (typeCtP.text.isEmpty) {
                                                errorType.value = true;
                                                isError = true;
                                              } else {
                                                errorType.value = false;
                                              }
                                              if (amountCtP.text.isEmpty) {
                                                errorAmount.value = true;
                                                isError = true;
                                              } else {
                                                errorAmount.value = false;
                                              }
                                              if (dateCtP.text.isEmpty ||
                                                  dateCtP.text.length != 10) {
                                                errorDate.value = true;
                                                isError = true;
                                              } else {
                                                errorDate.value = false;
                                              }
                                              if (timeCtP.text.isEmpty ||
                                                  timeCtP.text.length != 5) {
                                                errorTime.value = true;
                                                isError = true;
                                              } else {
                                                errorTime.value = false;
                                              }
                                              if (!isError) {
                                                casesCt.addPaymnet(
                                                    TinkPaymentModel(
                                                        id: 0,
                                                        name: nameCtP.text,
                                                        type: typeCtP.text,
                                                        amount: amountCtP.text,
                                                        info: infoCtP.text,
                                                        day: dateCtP.text
                                                            .split('.')[0],
                                                        month: dateCtP.text
                                                            .split('.')[1],
                                                        year: dateCtP.text
                                                            .split('.')[2],
                                                        time: timeCtP.text,
                                                        remind:
                                                            remindCtP.text));
                                                paymentsCt.getPayments();
                                                summaryCt.getSummary();
                                                Get.back();
                                              }
                                            } else {
                                              if (nameCtE.text.isEmpty) {
                                                errorNameE.value = true;
                                                isError = true;
                                              } else {
                                                errorNameE.value = false;
                                              }
                                              if (typeCtE.text.isEmpty) {
                                                errorTypeE.value = true;
                                                isError = true;
                                              } else {
                                                errorTypeE.value = false;
                                              }

                                              if (dateCtE.text.isEmpty ||
                                                  dateCtE.text.length != 10) {
                                                errorDateE.value = true;
                                                isError = true;
                                              } else {
                                                errorDateE.value = false;
                                              }
                                              if (timeCtE.text.isEmpty ||
                                                  timeCtE.text.length != 5) {
                                                errorTimeE.value = true;
                                                isError = true;
                                              } else {
                                                errorTimeE.value = false;
                                              }
                                              if (!isError) {
                                                casesCt.addEvent(TinkEventModel(
                                                    id: 0,
                                                    name: nameCtE.text,
                                                    type: typeCtE.text,
                                                    info: infoCtE.text,
                                                    day: dateCtE.text
                                                        .split('.')[0],
                                                    month: dateCtE.text
                                                        .split('.')[1],
                                                    year: dateCtE.text
                                                        .split('.')[2],
                                                    time: timeCtE.text,
                                                    remind: remindCtE.text));

                                                eventsCt.getEvents();
                                                Get.back();
                                              }
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

  void _updatePayment(TinkPaymentModel tinkPaymentModel) {
    final RxBool errorName = false.obs;
    final RxBool errorType = false.obs;
    final RxBool errorAmount = false.obs;
    final RxBool errorDate = false.obs;
    final RxBool errorTime = false.obs;
    final nameCt = TextEditingController(text: tinkPaymentModel.name);
    final typeCt = TextEditingController(text: tinkPaymentModel.type);
    final amountCt = TextEditingController(text: tinkPaymentModel.amount);
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
                                            'Let’s update payment:',
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
                                                      paymentsType.length,
                                                      (index) =>
                                                          GestureDetector(
                                                        onTap: () {
                                                          typeCt.text =
                                                              paymentsType[
                                                                  index];
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
                                                                paymentsType[
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
                                                              paymentsType[
                                                                          index] ==
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
                                      Obx(
                                        () => DialogTextField(
                                          leadingIcon: SvgPicture.asset(
                                            'tassets/icons/text_amount.svg',
                                            height: 15,
                                            fit: BoxFit.scaleDown,
                                          ),
                                          tinkCt: amountCt,
                                          isError: errorAmount.value,
                                          formatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          helperText: 'Amount, \$',
                                          tinkIcons: [const SizedBox()],
                                        ),
                                      ),
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
                                          formatters: [
                                            TimeTextFormatter(),
                                          ],
                                          isError: errorTime.value,
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
                                            if (amountCt.text.isEmpty) {
                                              errorAmount.value = true;
                                              isError = true;
                                            } else {
                                              errorAmount.value = false;
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
                                              casesCt.updatePaymnet(
                                                  TinkPaymentModel(
                                                id: tinkPaymentModel.id,
                                                name: nameCt.text,
                                                type: typeCt.text,
                                                amount: amountCt.text,
                                                info: infoCt.text,
                                                day: dateCt.text.split('.')[0],
                                                month:
                                                    dateCt.text.split('.')[1],
                                                year: dateCt.text.split('.')[2],
                                                time: timeCt.text,
                                                remind: remindCt.text,
                                              ));
                                              paymentsCt.getPayments();
                                              summaryCt.getSummary();
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
                                              casesCt.updateEvent(
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
                                              eventsCt.getEvents();
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
      appBar: TinkAppBar(widget.drawerKey), body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Calendar of Cases',
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
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GetBuilder(
                    init: casesCt,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              padding:
                                  const EdgeInsets.all(20).copyWith(top: 0),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(36, 36, 36, 1),
                                borderRadius: BorderRadius.circular(23),
                              ),
                              child: Obx(
                                () => TableCalendar(
                                  focusedDay: casesCt.selDate.value,
                                  weekendDays: const [DateTime.sunday],
                                  onDaySelected: (selectedDay, focusedDay) {
                                    casesCt.selDate.value = selectedDay;
                                    casesCt.getAllCases();
                                  },
                                  onPageChanged: (focusedDay) {
                                    casesCt.selDate.value = focusedDay;
                                    casesCt.selCalDate.value = focusedDay;
                                    casesCt.getAllCases();
                                  },
                                  headerStyle: const HeaderStyle(
                                    titleCentered: true,
                                    formatButtonVisible: false,
                                    leftChevronIcon: Icon(
                                      Icons.chevron_left,
                                      size: 40,
                                      color: Color.fromRGBO(142, 142, 147, 1),
                                    ),
                                    rightChevronIcon: Icon(
                                      Icons.chevron_right,
                                      size: 40,
                                      color: Color.fromRGBO(142, 142, 147, 1),
                                    ),
                                    titleTextStyle: TextStyle(
                                      fontFamily: 'Sarabun',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(245, 247, 248, 1),
                                    ),
                                  ),
                                  startingDayOfWeek: StartingDayOfWeek.monday,
                                  firstDay: DateTime.utc(
                                      DateTime.now().year - 1,
                                      DateTime.now().month,
                                      DateTime.now().day),
                                  lastDay: DateTime.utc(DateTime.now().year + 1,
                                      DateTime.now().month, DateTime.now().day),
                                  daysOfWeekHeight: 20,
                                  calendarStyle: const CalendarStyle(),
                                  daysOfWeekStyle: const DaysOfWeekStyle(
                                    weekdayStyle: TextStyle(
                                      fontFamily: 'Sarabun',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(142, 142, 147, 1),
                                    ),
                                    weekendStyle: TextStyle(
                                      fontFamily: 'Sarabun',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(142, 142, 147, 1),
                                    ),
                                  ),
                                  calendarBuilders: CalendarBuilders(
                                    defaultBuilder: (context, day, focusedDay) {
                                      return Container(
                                        height: 40,
                                        width: 40,
                                        decoration: casesCt.tinkCasesDate
                                                .where((e) {
                                          return e.year == day.year &&
                                              e.month == day.month &&
                                              e.day == day.day;
                                        }).isNotEmpty
                                            ? BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  width: 1.5,
                                                  color: Color.fromRGBO(
                                                      255,
                                                      219,
                                                      39,
                                                      day.isBefore(
                                                              DateTime.now())
                                                          ? 0.5
                                                          : 1),
                                                ),
                                                color: day == focusedDay
                                                    ? Color.fromRGBO(
                                                        255, 219, 39, 1)
                                                    : Colors.transparent,
                                              )
                                            : day == focusedDay
                                                ? BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color.fromRGBO(
                                                        142, 142, 147, 0.25),
                                                  )
                                                : null,
                                        alignment: Alignment.center,
                                        child: Text(
                                          day.day.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Sarabun',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: casesCt.tinkCasesDate
                                                    .where((e) {
                                              return e.year == day.year &&
                                                  e.month == day.month &&
                                                  e.day == day.day;
                                            }).isNotEmpty
                                                ? day == focusedDay
                                                    ? Color.fromRGBO(
                                                        36, 36, 36, 1)
                                                    : Color.fromRGBO(
                                                        255,
                                                        219,
                                                        39,
                                                        day.isBefore(
                                                                DateTime.now())
                                                            ? 0.5
                                                            : 1)
                                                : day.weekday == DateTime.sunday
                                                    ? const Color.fromRGBO(
                                                        234, 57, 78, 1)
                                                    : const Color.fromRGBO(
                                                        245, 247, 248, 1),
                                          ),
                                        ),
                                      );
                                    },
                                    todayBuilder: (context, day, focusedDay) {
                                      return Container(
                                        height: 40,
                                        width: 40,
                                        decoration: day == focusedDay
                                            ? const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    142, 142, 147, 0.25),
                                              )
                                            : null,
                                        alignment: Alignment.center,
                                        child: Text(
                                          day.day.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Sarabun',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                day.weekday == DateTime.sunday
                                                    ? const Color.fromRGBO(
                                                        234, 57, 78, 1)
                                                    : const Color.fromRGBO(
                                                        245, 247, 248, 1),
                                          ),
                                        ),
                                      );
                                    },
                                    outsideBuilder: (context, day, focusedDay) {
                                      return Container(
                                        height: 40,
                                        width: 40,
                                        alignment: Alignment.center,
                                        child: Text(
                                          day.day.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Sarabun',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                day.weekday == DateTime.sunday
                                                    ? const Color.fromRGBO(
                                                        234, 57, 78, 0.25)
                                                    : const Color.fromRGBO(
                                                        245, 247, 248, 0.25),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (casesCt.tinkCases.isEmpty)
                              const TinkCalendarEmptyCard()
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(bottom: 90),
                                itemCount: casesCt.tinkCases.length,
                                itemBuilder: (context, index) =>
                                    casesCt.tinkCases[index] is TinkPaymentModel
                                        ? TinkPaymentCard(
                                            tinkPaymentModel:
                                                casesCt.tinkCases[index],
                                            onUpdate: () => _updatePayment(
                                                casesCt.tinkCases[index]),
                                            onDelete: () {
                                              casesCt.deletePaymnet(
                                                  casesCt.tinkCases[index]);

                                              paymentsCt.getPayments();
                                              summaryCt.getSummary();
                                            },
                                          )
                                        : TinkEventCard(
                                            tinkEventModel:
                                                casesCt.tinkCases[index],
                                            onUpdate: () => _updateEvent(
                                                casesCt.tinkCases[index]),
                                            onDelete: () {
                                              casesCt.deleteEvent(
                                                  casesCt.tinkCases[index]);
                                              eventsCt.getEvents();
                                            },
                                          ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 7,
                                ),
                              ),
                            const SizedBox(
                              height: 90,
                            ),
                          ],
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _addCase();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 36, vertical: 12.5),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 219, 39, 1),
                              borderRadius: BorderRadius.circular(200),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Create new case',
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
