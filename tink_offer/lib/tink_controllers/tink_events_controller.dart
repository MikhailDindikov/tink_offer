import 'package:get/get.dart';
import 'package:tink_offer/tink_models/tink_event_model.dart';
import 'package:tink_offer/tink_utils/tink_db.dart';

class TinkEventsController extends GetxController {
  List<TinkEventModel> tinkEvents = [];
  RxInt orderType = 0.obs;
  RxInt selMonth = DateTime.now().month.obs;

  void sortDate() {
    tinkEvents.sort((a, b) {
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

  Future<void> addEvent(TinkEventModel newTinkPaymentModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.addTinkEvent(newTinkPaymentModel);
    tinkEvents = await tinkdb.getAllEvents(
        selMonth.value < 10 ? '0${selMonth.value}' : selMonth.value.toString(),
        DateTime.now().year.toString());
    sortDate();
  }

  Future<void> updateEvent(TinkEventModel newTinkPaymentModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.updateTinkEvent(newTinkPaymentModel);
    tinkEvents = await tinkdb.getAllEvents(
        selMonth.value < 10 ? '0${selMonth.value}' : selMonth.value.toString(),
        DateTime.now().year.toString());
    sortDate();
  }

  Future<void> deleteEvent(TinkEventModel tinkPaymentModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.deteleTinkEvent(tinkPaymentModel);
    tinkEvents = await tinkdb.getAllEvents(
        selMonth.value < 10 ? '0${selMonth.value}' : selMonth.value.toString(),
        DateTime.now().year.toString());
    sortDate();
  }

  Future<void> getEvents() async {
    final tinkdb = TinkDBHelper();
    tinkEvents = await tinkdb.getAllEvents(
        selMonth.value < 10 ? '0${selMonth.value}' : selMonth.value.toString(),
        DateTime.now().year.toString());
    sortDate();
  }
}
