import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

class TinkCaculatorCreditPage extends StatefulWidget {
  const TinkCaculatorCreditPage({
    super.key,
  });

  @override
  State<TinkCaculatorCreditPage> createState() =>
      _TinkCaculatorCreditPageState();
}

class _TinkCaculatorCreditPageState extends State<TinkCaculatorCreditPage> {
  RxInt debtSlide = 0.obs;
  RxInt srokSlideY = 0.obs;
  RxInt srokSlideM = 0.obs;
  RxDouble rateSlide = 0.0.obs;
  RxInt curSlideSrok = 0.obs;

  final srokTypes = ['year', 'month'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Color.fromRGBO(36, 36, 36, 1),
            borderRadius: BorderRadius.circular(23),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Loan Amount, \$',
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
                              text: '${debtSlide.value.toInt()}',
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(245, 247, 248, 1),
                              ),
                            ),
                            TextSpan(
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
                    max: 1000000,
                    activeColor: Color.fromRGBO(255, 219, 39, 1),
                    inactiveColor: Color.fromRGBO(142, 142, 147, 0.25),
                    value: debtSlide.value * 1.0,
                    onChanged: (double value) {
                      debtSlide.value = value.toInt();
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
                      '0\$',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(245, 247, 248, 0.25),
                      ),
                    ),
                    Text(
                      '1 000 000\$',
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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                                'Loan Term, ${srokTypes[curSlideSrok.value]}',
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(245, 247, 248, 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child:
                                  SvgPicture.asset('tassets/icons/bottom.svg'),
                            ),
                          ],
                        ),
                      );
                    }),
                    Obx(
                      () => Text(
                        '${curSlideSrok.value == 0 ? srokSlideY.value.toInt() : srokSlideM.value.toInt()}',
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
              ),
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => Slider(
                    min: 0,
                    max: curSlideSrok.value == 0 ? 35 : 12,
                    activeColor: Color.fromRGBO(255, 219, 39, 1),
                    inactiveColor: Color.fromRGBO(142, 142, 147, 0.25),
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
                        curSlideSrok.value == 0 ? '35' : '12',
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
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
                              text:
                                  '${rateSlide.value.toStringAsFixed(1).replaceAll('.', ',')}',
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(245, 247, 248, 1),
                              ),
                            ),
                            TextSpan(
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
                    activeColor: Color.fromRGBO(255, 219, 39, 1),
                    inactiveColor: Color.fromRGBO(142, 142, 147, 0.25),
                    value: rateSlide.value,
                    onChanged: (double value) {
                      rateSlide.value = double.parse(value.toStringAsFixed(1));
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
              SizedBox(
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
                '/calculator/credit_detal',
                (route) => true,
                id: 4,
                arguments: {
                  'allSum': debtSlide.value,
                  'percent': rateSlide.value,
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
