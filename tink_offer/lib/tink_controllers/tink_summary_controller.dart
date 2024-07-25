import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tink_offer/tink_models/tink_payment_model.dart';
import 'package:tink_offer/tink_utils/tink_db.dart';

class TinkSummaryController extends GetxController {
  List<TinkPaymentModel> tinkPayments = [];
  List<PieChartSectionData> tinkCharts = [];
  int all = 0;
  Rx<DateTime> selDate = DateTime.now().obs;
  int rent = 0;
  int salary = 0;
  int credit = 0;
  int another = 0;

  Future<void> nextDate() async {
    selDate.value = DateTime(
      selDate.value.month == 12 ? selDate.value.year + 1 : selDate.value.year,
      selDate.value.month == 12 ? 1 : selDate.value.month + 1,
      selDate.value.day,
    );
    
    await getSummary();
  }

  Future<void> prevDate() async {
    selDate.value = DateTime(
      selDate.value.month == 1 ? selDate.value.year - 1 : selDate.value.year,
      selDate.value.month == 1 ? 12 : selDate.value.month - 1,
      selDate.value.day,
    );

    tinkCharts.clear();
    update();
    await getSummary();
  }

  Future<void> getSummary() async {
    final tinkdb = TinkDBHelper();

    tinkPayments = await tinkdb.getAllPaymnets(
        selDate.value.month < 10
            ? '0${selDate.value.month}'
            : selDate.value.month.toString(),
        selDate.value.year.toString());

    rent = await tinkdb.getAllPaymnetsRent(
        selDate.value.month < 10
            ? '0${selDate.value.month}'
            : selDate.value.month.toString(),
        selDate.value.year.toString());
    salary = await tinkdb.getAllPaymnetsSalary(
        selDate.value.month < 10
            ? '0${selDate.value.month}'
            : selDate.value.month.toString(),
        selDate.value.year.toString());
    credit = await tinkdb.getAllPaymnetsCredit(
        selDate.value.month < 10
            ? '0${selDate.value.month}'
            : selDate.value.month.toString(),
        selDate.value.year.toString());
    another = await tinkdb.getAllPaymnetsAnother(
        selDate.value.month < 10
            ? '0${selDate.value.month}'
            : selDate.value.month.toString(),
        selDate.value.year.toString());

    all = rent + salary + another + credit;

    tinkCharts = [
      PieChartSectionData(
        showTitle: false,
        color: Color.fromRGBO(11, 220, 243, 1),
        value: all == 0 ? 0 : (salary / all) * 100,
        radius: 74,
      ),
      PieChartSectionData(
        showTitle: false,
        color: Color.fromRGBO(26, 174, 0, 1),
        value: all == 0 ? 0 : (rent / all) * 100,
        radius: 74,
      ),
      PieChartSectionData(
        showTitle: false,
        color: Color.fromRGBO(243, 143, 21, 1),
        value: all == 0 ? 0 : (credit / all) * 100,
        radius: 74,
      ),
      PieChartSectionData(
        showTitle: false,
        color: Color.fromRGBO(255, 26, 114, 1),
        value: all == 0 ? 0 : (another / all) * 100,
        radius: 74,
      ),
    ];

    update();
  }
}
