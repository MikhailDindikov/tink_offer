import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:tink_offer/tink_screens/tink_payments/tink_payments.dart';
import 'package:tink_offer/tink_screens/tink_profile/tink_profile_screen.dart';

class TinkSummaryScreen extends StatefulWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  const TinkSummaryScreen({required this.drawerKey, super.key});

  @override
  State<TinkSummaryScreen> createState() => _TinkSummaryScreenState();
}

class _TinkSummaryScreenState extends State<TinkSummaryScreen> {
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
              'Financial Summary',
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
          Expanded(child: SingleChildScrollView(child: SemiDonutChart())),
        ],
      ),
    );
  }
}

class SemiDonutChart extends StatefulWidget {
  const SemiDonutChart({super.key});

  @override
  State<SemiDonutChart> createState() => _SemiDonutChartState();
}

class _SemiDonutChartState extends State<SemiDonutChart> {
  final summaryCt = Get.find<TinkSummaryController>();
  final paymentsCt = Get.find<TinkPaymentsController>();
  final casesCt = Get.find<TinkCasesController>();
  final paymentsType = ['Rent', 'Credit', 'Another', 'Salary'];

  String get _tinkMonth {
    switch (summaryCt.selDate.value.month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
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
                                        helperText: 'Remind in ... days',
                                        formatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
                                        ],
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      summaryCt.getSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: summaryCt,
        builder: (_) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      summaryCt.prevDate();
                    },
                    child: Container(
                      height: 43,
                      width: 43,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(142, 142, 147, 0.25),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'tassets/icons/prev_date.svg',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 43,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(142, 142, 147, 0.25),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Text(
                      '$_tinkMonth ${summaryCt.selDate.value.year}',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(245, 247, 248, 1),
                        height: 1,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      summaryCt.nextDate();
                    },
                    child: Container(
                      height: 43,
                      width: 43,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(142, 142, 147, 0.25),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'tassets/icons/next_date.svg',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: Get.width - 60,
                          height: (Get.width - 30) / 2,
                          child: PieChart(
                            swapAnimationDuration: Duration.zero,
                            PieChartData(
                                sectionsSpace: 4, // Space between sections
                                startDegreeOffset:
                                    180, // Starts the chart at the top
                                centerSpaceRadius:
                                    90, // Creates a hole in the middle
                                sections: summaryCt.tinkCharts
                                  ..add(
                                    PieChartSectionData(
                                      showTitle: false,
                                      color: Colors.transparent,
                                      value: 100,
                                      radius: 74,
                                    ),
                                  )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 54),
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: summaryCt.all.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Sarabun',
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(245, 247, 248, 1),
                                        height: 1,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\$',
                                      style: TextStyle(
                                        fontFamily: 'Sarabun',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(245, 247, 248, 1),
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Total Expenses',
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(142, 142, 147, 1),
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 154,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(36, 36, 36, 1),
                                              borderRadius:
                                                  BorderRadius.circular(23),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color.fromRGBO(
                                                            11, 220, 243, 1),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: summaryCt
                                                                .salary
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Sarabun',
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      245,
                                                                      247,
                                                                      248,
                                                                      1),
                                                              height: 1,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: '\$',
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
                                                              height: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: SizedBox(
                                                    child: Text(
                                                      'Salary',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'Sarabun',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            142, 142, 147, 1),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(36, 36, 36, 1),
                                              borderRadius:
                                                  BorderRadius.circular(23),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color.fromRGBO(
                                                            26, 174, 0, 1),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: summaryCt.rent
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Sarabun',
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      245,
                                                                      247,
                                                                      248,
                                                                      1),
                                                              height: 1,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: '\$',
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
                                                              height: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: SizedBox(
                                                    child: Text(
                                                      'Rent',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'Sarabun',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            142, 142, 147, 1),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(36, 36, 36, 1),
                                              borderRadius:
                                                  BorderRadius.circular(23),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color.fromRGBO(
                                                            243, 143, 21, 1),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: summaryCt
                                                                .credit
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Sarabun',
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      245,
                                                                      247,
                                                                      248,
                                                                      1),
                                                              height: 1,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: '\$',
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
                                                              height: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: SizedBox(
                                                    child: Text(
                                                      'Credit',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'Sarabun',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            142, 142, 147, 1),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(36, 36, 36, 1),
                                              borderRadius:
                                                  BorderRadius.circular(23),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color.fromRGBO(
                                                            255, 26, 114, 1),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: summaryCt
                                                                .another
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Sarabun',
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      245,
                                                                      247,
                                                                      248,
                                                                      1),
                                                              height: 1,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: '\$',
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
                                                              height: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: SizedBox(
                                                    child: Text(
                                                      'Another',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'Sarabun',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            142, 142, 147, 1),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Expenses History',
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (summaryCt.tinkPayments.isEmpty)
                          const SizedBox()
                        else
                          Column(
                            children: List.generate(
                                summaryCt.tinkPayments.length,
                                (index) => Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: TinkPaymentCard(
                                        tinkPaymentModel:
                                            summaryCt.tinkPayments[index],
                                        onUpdate: () => _updatePayment(
                                            summaryCt.tinkPayments[index]),
                                        onDelete: () {
                                          paymentsCt.deletePaymnet(
                                              paymentsCt.tinkPayments[index]);
                                          casesCt.getAllCases();
                                          casesCt.getAllCasesDates();
                                          summaryCt.getSummary();
                                        },
                                      ),
                                    )),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        });
  }
}
