import 'package:get/get.dart';
import 'package:tink_offer/tink_controllers/tink_cases_controller.dart';
import 'package:tink_offer/tink_controllers/tink_events_controller.dart';
import 'package:tink_offer/tink_controllers/tink_payments_controller.dart';
import 'package:tink_offer/tink_controllers/tink_private_controller.dart';
import 'package:tink_offer/tink_controllers/tink_profile_controller.dart';
import 'package:tink_offer/tink_controllers/tink_summary_controller.dart';

class TinkBinds extends Bindings {
  @override
  void dependencies() {
    Get.put(TinkProfileController());
    Get.put(TinkPaymentsController());
    Get.put(TinkEventsController());
    Get.put(TinkCasesController());
    Get.put(TinkSummaryController());
    Get.put(TinkPrivateController());
  }
}
