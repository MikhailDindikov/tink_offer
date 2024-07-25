import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TinkProfileController extends GetxController {
  Uint8List? profImg;
  bool profPrem = false;
  RxBool profPremBuy = false.obs;
  RxBool profPremPurch = false.obs;

  String profName = 'Name';
  String profSurname = 'Surname';
  String profBd = '';
  

  Future<void> profInit() async {
    final profShar = await SharedPreferences.getInstance();
    final rawProfImg = profShar.getString('profImg');
    if (rawProfImg != null) {
      profImg = base64Decode(rawProfImg);
    }
    profName = profShar.getString('profName') ?? 'Name';
    profSurname = profShar.getString('profSurname') ?? 'Surname';
    profBd = profShar.getString('profBd') ?? '';
    profPrem = profShar.getBool('profPrem') ?? false;

    update();
  }

  Future<void> setProfImg(XFile newProfImg) async {
    profImg = await newProfImg.readAsBytes();
    update();
    final profShar = await SharedPreferences.getInstance();
    final a = await profShar.setString('profImg', base64.encode(profImg!.toList()));
    log(a.toString());
  }

  Future<void> setProfInfo(
      String newprofName, String newprofSurname, String newprofBd) async {
    profName = newprofName;
    profSurname = newprofSurname;
    profBd = newprofBd;
    final profShar = await SharedPreferences.getInstance();
    profShar.setString('profName', profName);
    profShar.setString('profSurname', profSurname);
    profShar.setString('profBd', profBd);
    update();
  }

  Future<void> setProfPrem() async {
    profPrem = true;
    final profShar = await SharedPreferences.getInstance();
    profShar.setBool('profPrem', true);
    update();
  }
}
