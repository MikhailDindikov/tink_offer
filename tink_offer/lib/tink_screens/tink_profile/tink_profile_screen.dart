import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tink_offer/tink_controllers/tink_profile_controller.dart';

class TinkProfileScreen extends StatefulWidget {
  const TinkProfileScreen({super.key});

  @override
  State<TinkProfileScreen> createState() => _TinkProfileScreenState();
}

class _TinkProfileScreenState extends State<TinkProfileScreen> {
  final nameCt = TextEditingController();
  final surnameCt = TextEditingController();
  final bdCt = TextEditingController();
  final profileCt = Get.find<TinkProfileController>();

  @override
  void initState() {
    nameCt.text = profileCt.profName;
    surnameCt.text = profileCt.profSurname;
    bdCt.text = profileCt.profBd;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 219, 39, 1),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: Get.back,
          child: Icon(
            CupertinoIcons.back,
            color: Color.fromRGBO(24, 24, 24, 1),
            size: 34,
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Sarabun',
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(24, 24, 24, 1),
          ),
        ),
      ),
      body: GetBuilder(
          init: profileCt,
          builder: (_) {
            return SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(24, 24, 24, 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Text(
                            '${profileCt.profName} ${profileCt.profSurname}',
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(245, 247, 248, 1),
                            ),
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 15)
                                    .copyWith(bottom: 25),
                                padding: EdgeInsets.all(20).copyWith(top: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23),
                                  color: Color.fromRGBO(36, 36, 36, 1),
                                ),
                                child: Column(
                                  children: [
                                    TinkTextField(
                                      tinkController: nameCt,
                                      helperText: 'Name',
                                      obsure: false,
                                      tinkIcons: [
                                        SvgPicture.asset(
                                          'tassets/icons/pen.svg',
                                          height: 16,
                                        )
                                      ],
                                    ),
                                    TinkTextField(
                                      tinkController: surnameCt,
                                      helperText: 'Surname',
                                      obsure: false,
                                      tinkIcons: [
                                        SvgPicture.asset(
                                          'tassets/icons/pen.svg',
                                          height: 16,
                                        )
                                      ],
                                    ),
                                    TinkTextField(
                                      tinkController: bdCt,
                                      helperText: 'Birth Date',
                                      obsure: false,
                                      tinkIcons: [
                                        SvgPicture.asset(
                                          'tassets/icons/pen.svg',
                                          height: 16,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    IntrinsicWidth(
                                      child: GestureDetector(
                                        onTap: () {
                                          profileCt.setProfInfo(nameCt.text,
                                              surnameCt.text, bdCt.text);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 36,
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(255, 219, 39, 1),
                                            borderRadius:
                                                BorderRadius.circular(200),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                              fontFamily: 'Sarabun',
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color.fromRGBO(24, 24, 24, 1),
                                            ),
                                          ),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final status = await Permission.photos.request();
                            //final status = await Permission.photos.status;
                            final _imagePicker = ImagePicker();
                            XFile? singleMedia = await _imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (singleMedia != null) {
                              profileCt.setProfImg(singleMedia);
                            }
                          },
                          child: Container(
                            height: 160,
                            width: 160,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(24, 24, 24, 1),
                            ),
                            child: Container(
                              padding:
                                  profileCt.profPrem ? EdgeInsets.all(4) : null,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(24, 24, 24, 1),
                                border: profileCt.profPrem
                                    ? Border.all(
                                        width: 5,
                                        color: Color.fromRGBO(255, 219, 39, 1))
                                    : null,
                              ),
                              child: profileCt.profImg == null
                                  ? Icon(
                                      Icons.person,
                                      color: Color.fromRGBO(36, 36, 36, 1),
                                      size: 50,
                                    )
                                  : Container(
                                      height: 160,
                                      width: 160,
                                      clipBehavior: Clip.hardEdge,
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      child: Image.memory(
                                        profileCt.profImg!,
                                        fit: BoxFit.cover,
                                        height: 160,
                                        width: 160,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(24, 24, 24, 1),
                            ),
                            child: SvgPicture.asset(
                              'tassets/icons/pen.svg',
                              fit: BoxFit.scaleDown,
                              height: 14,
                              width: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class TinkTextField extends StatelessWidget {
  final TextEditingController tinkController;
  final String helperText;
  final bool obsure;
  final List<Widget> tinkIcons;
  const TinkTextField(
      {required this.tinkController,
      required this.helperText,
      required this.obsure,
      required this.tinkIcons,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontFamily: 'Sarabun',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(245, 247, 248, 1),
      ),
      decoration: InputDecoration(
        helperText: helperText,
        helperStyle: TextStyle(
          fontFamily: 'Sarabun',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(142, 142, 147, 1),
        ),
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: tinkIcons,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(245, 247, 248, 0.25),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(245, 247, 248, 0.25),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(245, 247, 248, 0.25),
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(245, 247, 248, 0.25),
          ),
        ),
        hoverColor: Color.fromRGBO(245, 247, 248, 0.25),
        focusColor: Color.fromRGBO(245, 247, 248, 0.25),
      ),
      cursorColor: Color.fromRGBO(245, 247, 248, 1),
      controller: tinkController,
      obscureText: obsure,
    );
  }
}
