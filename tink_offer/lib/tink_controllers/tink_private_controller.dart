import 'package:get/get.dart';
import 'package:tink_offer/tink_models/tink_credential_model.dart';
import 'package:tink_offer/tink_models/tink_private_model.dart';
import 'package:tink_offer/tink_utils/tink_db.dart';

class TinkPrivateController extends GetxController {
  List<dynamic> tinkPrivates = [];

  Future<void> getAllPrivates() async {
    final tinkdb = TinkDBHelper();
    tinkPrivates.clear();

    final payments = await tinkdb.getAllPrivates();
    final events = await tinkdb.getAllCredentials();
    tinkPrivates.addAll(payments);
    tinkPrivates.addAll(events);
    tinkPrivates.sort((a, b) => a.id.compareTo(b.id));
    
    update();
  }

  Future<void> addPrivate(TinkPrivateModel newTinkPrivateModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.addTinkPrivate(newTinkPrivateModel);
    await getAllPrivates();
  }

  Future<void> updatePrivate(TinkPrivateModel newTinkPrivateModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.updateTinkPrivate(newTinkPrivateModel);
    await getAllPrivates();
  }

  Future<void> deletePrivate(TinkPrivateModel tinkPrivateModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.deteleTinkPrivate(tinkPrivateModel);
    await getAllPrivates();
  }

  Future<void> addCredentail(TinkCredentailModel newTinkCredentailModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.addTinkCredentail(newTinkCredentailModel);
    await getAllPrivates();
  }

  Future<void> updateCredentail(
      TinkCredentailModel newTinkCredentailModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.updateTinkCredentail(newTinkCredentailModel);
    await getAllPrivates();
  }

  Future<void> deleteCredentail(
      TinkCredentailModel newTinkCredentailModel) async {
    final tinkdb = TinkDBHelper();

    await tinkdb.deteleTinkCredentail(newTinkCredentailModel);
    await getAllPrivates();
  }
}
