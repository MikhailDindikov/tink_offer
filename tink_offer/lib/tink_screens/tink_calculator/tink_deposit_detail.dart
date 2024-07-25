import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tink_offer/tink_screens/tink_appbar.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';
import 'package:tink_offer/tink_screens/tink_profile/tink_profile_screen.dart';

class TinkDepositDetail extends StatelessWidget {
  final GlobalKey<InnerDrawerState> drawerKey;
  final bool isYear;
  final int deposit;
  final int months;
  final double percents;
  const TinkDepositDetail(
      {required this.drawerKey,
      super.key,
      required this.isYear,
      required this.deposit,
      required this.months,
      required this.percents});

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

  num depositMonth(int monthIndex) =>
      deposit * pow((1 + (percents / 100) / 12), monthIndex + 1);

  String get deposintPlus =>
      (depositMonth(months) - deposit).toInt().toString();

  List<Widget> get depositRows {
    final drows = <Widget>[];

    if (isYear) {
      var startDate = DateTime(
          DateTime.now().month == 12
              ? DateTime.now().year + 1
              : DateTime.now().year,
          DateTime.now().month == 12 ? 1 : DateTime.now().month + 1);
      var rawdrows = <String, int>{};
      for (int iDep = 1; iDep < months + 1; iDep++) {
        rawdrows['${startDate.year}'] = depositMonth(iDep).toInt();
        startDate = DateTime(
            startDate.month == 12 ? startDate.year + 1 : startDate.year,
            startDate.month == 12 ? 1 : startDate.month + 1);
      }
      for (final key in rawdrows.keys) {
        drows.add(DepositRow(date: key, depo: rawdrows[key].toString()));
      }
    } else {
      var startDate = DateTime(
          DateTime.now().month == 12
              ? DateTime.now().year + 1
              : DateTime.now().year,
          DateTime.now().month == 12 ? 1 : DateTime.now().month + 1);
      for (int iDep = 1; iDep < months + 1; iDep++) {
        drows.add(DepositRow(
            date: '${_tinkMonth(startDate.month)} ${startDate.year}',
            depo: depositMonth(iDep).toInt().toString()));
        startDate = DateTime(
            startDate.month == 12 ? startDate.year + 1 : startDate.year,
            startDate.month == 12 ? 1 : startDate.month + 1);
      }
    }

    return drows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      appBar: TinkAppBar(drawerKey),
      body: Column(
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
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(36, 36, 36, 1),
                          borderRadius: BorderRadius.circular(23),
                          border: Border.all(
                            width: 1.5,
                            color: Color.fromRGBO(255, 219, 39, 1),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: deposintPlus,
                                  style: TextStyle(
                                    fontFamily: 'Sarabun',
                                    fontSize: 32,
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
                          Text(
                            'Deposit Income',
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(142, 142, 147, 1),
                            ),
                          ),
                          Container(
                            height: 2,
                            margin: EdgeInsets.only(top: 10, bottom: 5),
                            color: Color.fromRGBO(142, 142, 147, 0.25),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: depositMonth(months).toInt().toString(),
                                  style: TextStyle(
                                    fontFamily: 'Sarabun',
                                    fontSize: 32,
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
                          Text(
                            'Amount\nof the end-of-term payment',
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(142, 142, 147, 1),
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
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(36, 36, 36, 1),
                        borderRadius: BorderRadius.circular(23),
                      ),
                      child: Column(
                        children: depositRows..insert(0, DepositHeader()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DepositHeader extends StatelessWidget {
  const DepositHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Date',
            style: TextStyle(
              fontFamily: 'Sarabun',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(142, 142, 147, 1),
            ),
          ),
          Text(
            'Amount of Interest %',
            style: TextStyle(
              fontFamily: 'Sarabun',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(142, 142, 147, 1),
            ),
          ),
        ],
      ),
    );
  }
}

class DepositRow extends StatelessWidget {
  final String date;
  final String depo;
  const DepositRow({super.key, required this.date, required this.depo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: TextStyle(
              fontFamily: 'Sarabun',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(245, 247, 248, 1),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: depo,
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
        ],
      ),
    );
  }
}
