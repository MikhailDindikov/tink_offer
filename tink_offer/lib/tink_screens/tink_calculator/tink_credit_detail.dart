import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tink_offer/tink_screens/tink_appbar.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';
import 'package:tink_offer/tink_screens/tink_profile/tink_profile_screen.dart';

class TinkCreditDetail extends StatelessWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  final int allSum;
  final double percent;
  final int months;
  const TinkCreditDetail(
      {required this.drawerKey,
      required this.allSum,
      required this.percent,
      required this.months,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      appBar: TinkAppBar(drawerKey), body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 9, left: 16),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.back(id: 4);
                  },
                  child: Icon(
                    CupertinoIcons.back,
                    color: Color.fromRGBO(245, 247, 248, 1),
                    size: 34,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Credit Calculator Results',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Sarabun',
                    fontSize: 32,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(245, 247, 248, 1),
                  ),
                ),
              ),
              Opacity(
                opacity: 0,
                child: IgnorePointer(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: Get.back,
                    child: Icon(
                      CupertinoIcons.back,
                      color: Color.fromRGBO(24, 24, 24, 1),
                      size: 34,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SemiDonutChart(
              allSum: allSum,
              percent: percent,
              months: months,
            ),
          ))),
        ],
      ),
    );
  }
}

class SemiDonut extends CustomPainter {
  void drawDataArc(
    Canvas canvas,
    Size size,
  ) {
    final percents = [56, 4, 15, 15, 10];
    canvas.translate(size.width / 2, 100);
    canvas.drawCircle(
        Offset.zero,
        5,
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.amber);
    canvas.drawCircle(
        Offset.zero,
        1,
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.blue);
    canvas.save();
    canvas.rotate(pi);
    const polarRadius = 4;

    var sumStep = 0.0;

    for (var i = 0; i < percents.length; i++) {
      final curAngle = (percents[i] / 100) * pi;
      final polarAngle = sumStep + curAngle / 2;
      final xPos = polarRadius * cos(polarAngle);
      final yPos = polarRadius * sin(polarAngle);

      canvas.save();
      if (polarAngle < pi / 2) {
        canvas.translate(xPos, yPos);
      } else if (polarAngle < pi) {
        canvas.translate(xPos, yPos);
      }
      final path = Path();
      path.moveTo(0, 0);
      path.arcTo(
        Rect.fromCircle(center: Offset.zero, radius: 100),
        sumStep,
        curAngle,
        false,
      );

      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.red,
      );
      canvas.restore();
      sumStep += curAngle;
    }

    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawDataArc(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SemiDonutChart extends StatelessWidget {
  final int allSum;
  final double percent;
  final int months;
  const SemiDonutChart(
      {super.key,
      required this.allSum,
      required this.percent,
      required this.months});

  double get monthPercent => percent / (12 * 100);

  double get monthSum {
    return allSum *
        ((monthPercent * pow(1 + monthPercent, months)) /
            (pow(1 + monthPercent, months) - 1));
  }

  double get totalSum => monthSum * months;

  double get percentsSum => totalSum - allSum;

  String _tinkMonth(int month) {
    switch (month) {
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

  String get endDate {
    final startDate = DateTime.now();
    final yR = months ~/ 12;
    final mR = months % 12;
    var rawEndDate =
        DateTime(startDate.year + yR, startDate.month, startDate.day);
    rawEndDate = DateTime(rawEndDate.year + (mR + rawEndDate.month) ~/ 12,
        (mR + rawEndDate.month) % 12, rawEndDate.day);
    final endDate = DateTime(
        rawEndDate.month == 12 ? rawEndDate.year + 1 : rawEndDate.year,
        rawEndDate.month == 12 ? 1 : rawEndDate.month + 1,
        rawEndDate.day);
    return '${_tinkMonth(endDate.month)} ${endDate.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    startDegreeOffset: 180, // Starts the chart at the top
                    centerSpaceRadius: 90, // Creates a hole in the middle
                    sections: [
                      PieChartSectionData(
                        showTitle: false,
                        color: Color.fromRGBO(255, 219, 39, 1),
                        value: (totalSum == 0 ? 0 : allSum / totalSum) * 100,
                        radius: 74,
                      ),
                      PieChartSectionData(
                        showTitle: false,
                        color: Color.fromRGBO(245, 247, 248, 0.25),
                        value:
                            100 - (totalSum == 0 ? 0 : allSum / totalSum) * 100,
                        radius: 74,
                      ),
                      PieChartSectionData(
                        showTitle: false,
                        color: Colors.transparent,
                        value: 100,
                        radius: 74,
                      ),
                    ],
                  ),
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
                            text: totalSum.toStringAsFixed(0),
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
                      'Total Payout',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 20,
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(36, 36, 36, 1),
                              borderRadius: BorderRadius.circular(23),
                              border: Border.all(
                                width: 1.5,
                                color: Color.fromRGBO(255, 219, 39, 1),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: monthSum.toStringAsFixed(0),
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
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(245, 247, 248, 1),
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  'Monthly Payments',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Sarabun',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(142, 142, 147, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(36, 36, 36, 1),
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromRGBO(255, 219, 39, 1),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: allSum.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Sarabun',
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  245, 247, 248, 1),
                                              height: 1,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '\$',
                                            style: TextStyle(
                                              fontFamily: 'Sarabun',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  245, 247, 248, 1),
                                              height: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  child: Text(
                                    'Loan Amount',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Sarabun',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(142, 142, 147, 1),
                                    ),
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Details',
                  style: TextStyle(
                    fontFamily: 'Sarabun',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(36, 36, 36, 1),
                      borderRadius: BorderRadius.circular(23)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interest Rate',
                        style: TextStyle(
                          fontFamily: 'Sarabun',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(142, 142, 147, 1),
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: percent.toString(),
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
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: Text(
                          'Overpayments Percentage',
                          style: TextStyle(
                            fontFamily: 'Sarabun',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(142, 142, 147, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: (100 -
                                      (totalSum == 0
                                              ? 0
                                              : percentsSum / totalSum) *
                                          100)
                                  .toStringAsFixed(1),
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'The End Of Payments',
                        style: TextStyle(
                          fontFamily: 'Sarabun',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(142, 142, 147, 1),
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        endDate,
                        style: TextStyle(
                          fontFamily: 'Sarabun',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(245, 247, 248, 1),
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
        )
      ],
    );
  }
}
