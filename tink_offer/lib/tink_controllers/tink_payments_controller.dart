import 'package:get/get.dart';
import 'package:tink_offer/tink_models/tink_payment_model.dart';
import 'package:tink_offer/tink_utils/tink_db.dart';

class TinkPaymentsController extends GetxController {
  List<TinkPaymentModel> tinkPayments = [];
  RxInt orderType = 0.obs;
  RxInt selMonth = DateTime.now().month.obs;

  void sortDate() {
    tinkPayments.sort((a, b) {
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
    tinkPayments = await tinkdb.getAllPaymnets(
        selMonth.value < 10 ? '0${selMonth.value}' : selMonth.value.toString(),
        DateTime.now().year.toString());
    sortDate();
  }

  Future<void> updatePaymnet(TinkPaymentModel newTinkPaymentModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.updateTinkPayment(newTinkPaymentModel);
    tinkPayments = await tinkdb.getAllPaymnets(
        selMonth.value < 10 ? '0${selMonth.value}' : selMonth.value.toString(),
        DateTime.now().year.toString());
    sortDate();
  }

  Future<void> deletePaymnet(TinkPaymentModel tinkPaymentModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.deteleTinkPayment(tinkPaymentModel);
    tinkPayments = await tinkdb.getAllPaymnets(
        selMonth.value < 10 ? '0${selMonth.value}' : selMonth.value.toString(),
        DateTime.now().year.toString());
    sortDate();
  }

  Future<void> getPayments() async {
    final tinkdb = TinkDBHelper();
    tinkPayments = await tinkdb.getAllPaymnets(
        selMonth.value < 10 ? '0${selMonth.value}' : selMonth.value.toString(),
        DateTime.now().year.toString());
    sortDate();
  }
}
