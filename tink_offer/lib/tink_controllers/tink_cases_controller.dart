import 'package:get/get.dart';
import 'package:tink_offer/tink_models/tink_event_model.dart';
import 'package:tink_offer/tink_models/tink_payment_model.dart';
import 'package:tink_offer/tink_utils/tink_db.dart';

class TinkCasesController extends GetxController {
  List<dynamic> tinkCases = [];
  List<DateTime> tinkCasesDate = [];
  RxInt orderType = 0.obs;
  Rx<DateTime> selCalDate = DateTime.now().obs;
  Rx<DateTime> selDate = DateTime.now().obs;

  Future<void> getAllCasesDates() async {
    final tinkdb = TinkDBHelper();
    tinkCasesDate.clear();

    final paymentsDate = await tinkdb.getAllPaymnetsDate(
        selCalDate.value.month < 10
            ? '0${selCalDate.value.month}'
            : selCalDate.value.month.toString(),
        selCalDate.value.year.toString());

    final eventsDate = await tinkdb.getAllEventsDate(
        selDate.value.month < 10
            ? '0${selCalDate.value.month}'
            : selCalDate.value.month.toString(),
        selCalDate.value.year.toString());

    paymentsDate.addAll(eventsDate);

    for (final date in paymentsDate) {
      tinkCasesDate.add(DateTime(selCalDate.value.year, selCalDate.value.month,
          date[0] == '0' ? int.parse(date[1]) : int.parse(date)));
    }
    update();
  }

  Future<void> getAllCases() async {
    final tinkdb = TinkDBHelper();
    tinkCases.clear();

    getAllCasesDates();
    final payments = await tinkdb.getAllPaymnetsDaily(
        selDate.value.day < 10
            ? '0${selDate.value.day}'
            : selDate.value.day.toString(),
        selDate.value.month < 10
            ? '0${selDate.value.month}'
            : selDate.value.month.toString(),
        selDate.value.year.toString());
    final events = await tinkdb.getAllEventsDaily(
        selDate.value.day < 10
            ? '0${selDate.value.day}'
            : selDate.value.day.toString(),
        selDate.value.month < 10
            ? '0${selDate.value.month}'
            : selDate.value.month.toString(),
        selDate.value.year.toString());
    tinkCases.addAll(payments);
    tinkCases.addAll(events);
    sortDate();
  }

  void sortDate() {
    tinkCases.sort((a, b) {
      final aDate = DateTime(
          int.parse(a.year),
          int.parse(a.month),
          int.parse(a.day),
          int.parse(a.time.split(':')[0]),
          int.parse(a.time.split(':')[1]));
      final bDate = DateTime(
          int.parse(b.year),
          int.parse(b.month),
          int.parse(b.day),
          int.parse(b.time.split(':')[0]),
          int.parse(b.time.split(':')[1]));

      if (orderType.value == 1) {
        return aDate.compareTo(bDate);
      } else {
        return bDate.compareTo(aDate);
      }
    });

    update();
  }

  Future<void> addPaymnet(TinkPaymentModel newTinkPaymentModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.addTinkPayment(newTinkPaymentModel);
    await getAllCases();
  }

  Future<void> updatePaymnet(TinkPaymentModel newTinkPaymentModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.updateTinkPayment(newTinkPaymentModel);
    await getAllCases();
  }

  Future<void> deletePaymnet(TinkPaymentModel tinkPaymentModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.deteleTinkPayment(tinkPaymentModel);
    await getAllCases();
  }

  Future<void> addEvent(TinkEventModel newTinkPaymentModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.addTinkEvent(newTinkPaymentModel);

    await getAllCases();
  }

  Future<void> updateEvent(TinkEventModel newTinkPaymentModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.updateTinkEvent(newTinkPaymentModel);
    await getAllCases();
  }

  Future<void> deleteEvent(TinkEventModel tinkPaymentModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.deteleTinkEvent(tinkPaymentModel);
    await getAllCases();
  }
}
