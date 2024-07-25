import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:tink_offer/formatters/date_formatter.dart';
import 'package:tink_offer/formatters/time_formatter.dart';
import 'package:tink_offer/tink_controllers/tink_cases_controller.dart';
import 'package:tink_offer/tink_controllers/tink_payments_controller.dart';
import 'package:tink_offer/tink_controllers/tink_summary_controller.dart';
import 'package:tink_offer/tink_models/tink_payment_model.dart';
import 'package:tink_offer/tink_screens/dialog_text_field.dart';
import 'package:tink_offer/tink_screens/tink_appbar.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';
import 'package:tink_offer/tink_screens/tink_profile/tink_profile_screen.dart';

class TinkPayments extends StatefulWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  const TinkPayments({required this.drawerKey, super.key});

  @override
  State<TinkPayments> createState() => _TinkPaymentsState();
}

class _TinkPaymentsState extends State<TinkPayments> {
  final orderFilters = ['The latest', 'The newest'];
  final paymentsType = ['Rent', 'Credit', 'Another', 'Salary'];
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
  final paymentsCt = Get.find<TinkPaymentsController>();
  final casesCt = Get.find<TinkCasesController>();
  final summaryCt = Get.find<TinkSummaryController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      paymentsCt.getPayments();
    });
  }

  void _addPayment() {
    final RxBool errorName = false.obs;
    final RxBool errorType = false.obs;
    final RxBool errorAmount = false.obs;
    final RxBool errorDate = false.obs;
    final RxBool errorTime = false.obs;
    final nameCt = TextEditingController();
    final typeCt = TextEditingController();
    final amountCt = TextEditingController();
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
                                          isError: errorAmount.value,
                                          tinkCt: amountCt,
                                          helperText: 'Amount, \$',
                                          formatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
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
                                          helperText: 'Date',
                                          formatters: [DateTextFormatter()],
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
                                          formatters: [TimeTextFormatter()],
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
                                              paymentsCt.addPaymnet(
                                                  TinkPaymentModel(
                                                      id: 0,
                                                      name: nameCt.text,
                                                      type: typeCt.text,
                                                      amount: amountCt.text,
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
                                          helperText: 'Amount, \$',
                                          formatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
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
                                          formatters: [DateTextFormatter()],
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
                                          formatters: [TimeTextFormatter()],
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
                                              paymentsCt.updatePaymnet(
                                                  TinkPaymentModel(
                                                      id: tinkPaymentModel.id,
                                                      name: nameCt.text,
                                                      type: typeCt.text,
                                                      amount: amountCt.text,
                                                      info: infoCt.text,
                                                      day: dateCt
                                                          .text
                                                          .split('.')[0],
                                                      month: dateCt.text
                                                          .split('.')[1],
                                                      year: dateCt.text
                                                          .split('.')[2],
                                                      time: timeCt.text,
                                                      remind: remindCt.text));
                                              casesCt.getAllCases();
                                              casesCt.getAllCasesDates();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      appBar: TinkAppBar(widget.drawerKey),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Payments',
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
                                        paymentsCt.orderType.value = index;
                                        paymentsCt.sortDate();
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
                                                      paymentsCt.orderType.value
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
                                  orderFilters[paymentsCt.orderType.value],
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
                                          paymentsCt.selMonth.value = index + 1;
                                          paymentsCt.getPayments();
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
                                                        paymentsCt.selMonth
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
                                  monthFilters[paymentsCt.selMonth.value - 1],
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
                    init: paymentsCt,
                    builder: (_) {
                      if (paymentsCt.tinkPayments.isEmpty) {
                        return const SizedBox();
                      } else {
                        return ListView.separated(
                          padding: const EdgeInsets.only(bottom: 90),
                          itemCount: paymentsCt.tinkPayments.length,
                          itemBuilder: (context, index) => TinkPaymentCard(
                            tinkPaymentModel: paymentsCt.tinkPayments[index],
                            onUpdate: () =>
                                _updatePayment(paymentsCt.tinkPayments[index]),
                            onDelete: () {
                              paymentsCt.deletePaymnet(
                                  paymentsCt.tinkPayments[index]);
                              casesCt.getAllCases();
                              casesCt.getAllCasesDates();
                              summaryCt.getSummary();
                            },
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 7,
                          ),
                        );
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _addPayment();
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
                              'Create new payment',
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

class TinkPaymentCard extends StatelessWidget {
  final TinkPaymentModel tinkPaymentModel;
  final void Function() onUpdate;
  final void Function() onDelete;
  const TinkPaymentCard(
      {required this.tinkPaymentModel,
      required this.onUpdate,
      required this.onDelete,
      super.key});

  Color get _tinkColor {
    switch (tinkPaymentModel.type) {
      case 'Rent':
        return Color.fromRGBO(26, 174, 0, 1);
      case 'Credit':
        return Color.fromRGBO(243, 143, 21, 1);
      case 'Another':
        return Color.fromRGBO(255, 26, 114, 1);
      case 'Salary':
        return Color.fromRGBO(11, 220, 243, 1);
      default:
        return Color.fromRGBO(36, 36, 36, 1);
    }
  }

  String get _tinkMonth {
    switch (tinkPaymentModel.month) {
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Payment',
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
                                      tinkPaymentModel.name,
                                      style: const TextStyle(
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
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    key: key,
                                    height: 100,
                                    width: 100,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(255, 214, 10, 0.25),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: AutoSizeText(
                                        '${tinkPaymentModel.amount}\$',
                                        group: AutoSizeGroup(),
                                        key: UniqueKey(),
                                        maxFontSize: 40,
                                        textScaleFactor: 1,
                                        minFontSize: 5,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromRGBO(255, 219, 39, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Builder(builder: (__) {
                                    return GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        showPopover(
                                          context: __,
                                          direction: PopoverDirection.bottom,
                                          radius: 23,
                                          backgroundColor: const Color.fromRGBO(
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
                                                        color: const Color
                                                            .fromRGBO(142, 142,
                                                            147, 0.25),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
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
                                                        color: const Color
                                                            .fromRGBO(142, 142,
                                                            147, 0.25),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
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
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                tinkPaymentModel.info,
                                style: const TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(142, 142, 147, 1),
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                        const SizedBox(
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
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              tinkPaymentModel.type,
                              style: const TextStyle(
                                fontFamily: 'Sarabun',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(142, 142, 147, 1),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    const Color.fromRGBO(142, 142, 147, 0.25),
                                borderRadius: BorderRadius.circular(200),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${tinkPaymentModel.day} $_tinkMonth ${tinkPaymentModel.year}',
                                style: const TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(245, 247, 248, 1),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    const Color.fromRGBO(142, 142, 147, 0.25),
                                borderRadius: BorderRadius.circular(200),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                tinkPaymentModel.time,
                                style: const TextStyle(
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
