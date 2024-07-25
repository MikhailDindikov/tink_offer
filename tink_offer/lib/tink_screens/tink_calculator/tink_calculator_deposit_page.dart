import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:tink_offer/tink_screens/tink_calculator/tink_caculator_screen.dart';

class TinkCaculatorDepositPage extends StatefulWidget {
  const TinkCaculatorDepositPage({
    super.key,
  });

  @override
  State<TinkCaculatorDepositPage> createState() =>
      _TinkCaculatorDepositPageState();
}

class _TinkCaculatorDepositPageState extends State<TinkCaculatorDepositPage> {
  RxInt depositSlide = 0.obs;
  RxInt srokSlideY = 0.obs;
  RxInt srokSlideM = 0.obs;
  RxDouble rateSlide1 = 0.0.obs;
  RxInt curSlide1 = 1.obs;
  RxInt curSlideSrok = 0.obs;

  final srokTypes = ['year', 'month'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(36, 36, 36, 1),
            borderRadius: BorderRadius.circular(23),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Deposit Amount, \$',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(245, 247, 248, 1),
                      ),
                    ),
                    Obx(
                      () => RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${depositSlide.value.toInt()}',
                              style: const TextStyle(
                                fontFamily: 'Sarabun',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(245, 247, 248, 1),
                              ),
                            ),
                            const TextSpan(
                              text: '\$',
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
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => Slider(
                    min: 0,
                    max: 300000,
                    activeColor: const Color.fromRGBO(255, 219, 39, 1),
                    inactiveColor: const Color.fromRGBO(142, 142, 147, 0.25),
                    value: depositSlide.value * 1.0,
                    onChanged: (double value) {
                      depositSlide.value = value.toInt();
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '0\$',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(245, 247, 248, 0.25),
                      ),
                    ),
                    Text(
                      '300 000\$',
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                  top: 0, bottom: 7, left: 15, right: 20),
                              child: IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    srokTypes.length,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        curSlideSrok.value = index;
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
                                              srokTypes[index],
                                              style: const TextStyle(
                                                fontFamily: 'Sarabun',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(
                                                    245, 247, 248, 1),
                                              ),
                                            ),
                                            Obx(
                                              () => index == curSlideSrok.value
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
                        child: Row(
                          children: [
                            Obx(
                              () => Text(
                                'Deposit Term, ${srokTypes[curSlideSrok.value]}',
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(245, 247, 248, 1),
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: SvgPicture.asset('tassets/icons/bottom.svg'),
                            ),
                          ],
                        ),
                      );
                    }),
                    Obx(
                      () => Text(
                        '${curSlideSrok.value == 0 ? srokSlideY.value.toInt() : srokSlideM.value.toInt()}',
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
              ),
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => Slider(
                    min: 0,
                    max: curSlideSrok.value == 0 ? 10 : 12,
                    activeColor: const Color.fromRGBO(255, 219, 39, 1),
                    inactiveColor: const Color.fromRGBO(142, 142, 147, 0.25),
                    value: curSlideSrok.value == 0
                        ? srokSlideY.value * 1.0
                        : srokSlideM.value * 1.0,
                    onChanged: (double value) {
                      if (curSlideSrok.value == 0) {
                        srokSlideY.value = value.toInt();
                      } else {
                        srokSlideM.value = value.toInt();
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '0',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(245, 247, 248, 0.25),
                      ),
                    ),
                    Obx(
                      () => Text(
                        curSlideSrok.value == 0 ? '10' : '12',
                        style: TextStyle(
                          fontFamily: 'Sarabun',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(245, 247, 248, 0.25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => curSlideSrok.value == 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Payment Frequency',
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(245, 247, 248, 1),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
              Obx(
                () => curSlideSrok.value == 0
                    ? SizedBox(
                        height: 15,
                      )
                    : SizedBox(),
              ),
              Obx(
                () => curSlideSrok.value == 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomSlidingSegmentedControl(
                            innerPadding: EdgeInsets.zero,
                            padding: 20,
                            height: 48,
                            children: {
                              1: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 8, right: 20, bottom: 10),
                                child: Obx(
                                  () => Text(
                                    'Yearly',
                                    style: TextStyle(
                                      fontFamily: 'Sarabun',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: curSlide1.value == 1
                                          ? Color.fromRGBO(36, 36, 36, 1)
                                          : Color.fromRGBO(142, 142, 147, 1),
                                    ),
                                  ),
                                ),
                              ),
                              2: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 8, right: 20, bottom: 10),
                                child: Obx(
                                  () => Text(
                                    'Monthly',
                                    style: TextStyle(
                                      fontFamily: 'Sarabun',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: curSlide1.value == 2
                                          ? Color.fromRGBO(36, 36, 36, 1)
                                          : Color.fromRGBO(142, 142, 147, 1),
                                    ),
                                  ),
                                ),
                              ),
                            },
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(142, 142, 147, 0.25),
                              borderRadius: BorderRadius.circular(200),
                            ),
                            thumbDecoration: BoxDecoration(
                              color: Color.fromRGBO(255, 219, 39, 1),
                              borderRadius: BorderRadius.circular(200),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.3),
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
                              curSlide1.value = value;
                            },
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Interest Rate, %',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(245, 247, 248, 1),
                      ),
                    ),
                    Obx(
                      () => RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: rateSlide1.value
                                  .toStringAsFixed(1)
                                  .replaceAll('.', ','),
                              style: const TextStyle(
                                fontFamily: 'Sarabun',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(245, 247, 248, 1),
                              ),
                            ),
                            const TextSpan(
                              text: '%',
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
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => Slider(
                    min: 0,
                    max: 20,
                    activeColor: const Color.fromRGBO(255, 219, 39, 1),
                    inactiveColor: const Color.fromRGBO(142, 142, 147, 0.25),
                    value: rateSlide1.value,
                    onChanged: (double value) {
                      rateSlide1.value = double.parse(value.toStringAsFixed(1));
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '0',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(245, 247, 248, 0.25),
                      ),
                    ),
                    Text(
                      '20',
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
              const SizedBox(
                height: 20,
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
              Get.offNamedUntil<void>(
                '/calculator/deposit_detal',
                (route) => true,
                id: 4,
                arguments: {
                  'deposit': depositSlide.value,
                  'percent': rateSlide1.value,
                  'isYear':
                      curSlideSrok.value != 0 ? false : curSlide1.value == 1,
                  'months': curSlideSrok.value == 0
                      ? srokSlideY.value * 12
                      : srokSlideM.value
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 12.5),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 219, 39, 1),
                borderRadius: BorderRadius.circular(200),
              ),
              alignment: Alignment.center,
              child: Text(
                'Calculate',
                style: TextStyle(
                  fontFamily: 'Sarabun',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(24, 24, 24, 1),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
