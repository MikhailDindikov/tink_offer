import 'package:apphud/apphud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tink_offer/tink_binds.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';
import 'package:tink_offer/tink_screens/tink_preview/tink_preview_screen.dart';

class TinkStart {
  static late bool tinkStartDemo;

  static Future<void> tinkDemo() async {
    final profShar = await SharedPreferences.getInstance();
    tinkStartDemo = profShar.getBool('tinkStartDemo') ?? true;
  }

  static Future<void> tinkDemoStop() async {
    final profShar = await SharedPreferences.getInstance();
    profShar.setBool('tinkStartDemo', false);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Apphud.start(apiKey: 'app_wWtgMo58CvotqY6VeKbUQKxHAABdRc');
  await TinkStart.tinkDemo();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const TinkOfferApp());
}

class TinkOfferApp extends StatelessWidget {
  const TinkOfferApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: TinkBinds(),
      title: 'Tink Offer',
      theme: ThemeData(
        fontFamily: 'Sarabun',
        useMaterial3: false,
      ),
      home: TinkStart.tinkStartDemo
          ? TinkPreviewScreen()
          : const TinkMainScreen(),
    );
  }
}
