import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:tink_offer/main.dart';
import 'package:tink_offer/tink_screens/tink_main/tink_main_screen.dart';

class TinkPreviewScreen extends StatefulWidget {
  const TinkPreviewScreen({super.key});

  @override
  State<TinkPreviewScreen> createState() => _TinkPreviewScreenState();
}

class _TinkPreviewScreenState extends State<TinkPreviewScreen> {
  RxInt tinkPage = 0.obs;
  final tinkController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: double.infinity,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tinkController,
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Image.asset(
                      'tassets/images/1st.png',
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 130, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textDirection: TextDirection.ltr,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Welcome to\n',
                                    style: TextStyle(
                                        fontFamily: 'Sarabun',
                                        fontSize: 36,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(245, 247, 248, 1),
                                        letterSpacing: 1,
                                        height: 1)),
                                TextSpan(
                                    text: 'Tink Offer:\nBusiness  Assistant!',
                                    style: TextStyle(
                                        fontFamily: 'Sarabun',
                                        fontSize: 36,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(255, 219, 39, 1),
                                        letterSpacing: 1,
                                        height: 1)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Handle your business\ntasks in one place',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(245, 247, 248, 0.25),
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      'tassets/images/2nd.png',
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 130),
                      child: IntrinsicWidth(
                        child: IntrinsicHeight(
                          child: Container(
                            padding:
                                const EdgeInsets.all(20).copyWith(bottom: 25),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(36, 36, 36, 1),
                              borderRadius: BorderRadius.circular(23),
                              border: Border.all(
                                width: 1.5,
                                color: const Color.fromRGBO(255, 219, 39, 1),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 219, 39, 1),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'Salaries',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                245, 247, 248, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 219, 39, 1),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'Tenders',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                245, 247, 248, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 219, 39, 1),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'Meetings',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                245, 247, 248, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 219, 39, 1),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'Secure Data',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                245, 247, 248, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 219, 39, 1),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'Loans',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                245, 247, 248, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 219, 39, 1),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'Debts',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                245, 247, 248, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 219, 39, 1),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'Events',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                245, 247, 248, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 219, 39, 1),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'Leases',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                245, 247, 248, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => AnimatedContainer(
                        duration: 300.ms,
                        height: 5,
                        width: tinkPage.value == 0 ? 25 : 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.5),
                          color: tinkPage.value == 0
                              ? const Color.fromRGBO(245, 247, 248, 1)
                              : const Color.fromRGBO(245, 247, 248, 0.30),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Obx(
                      () => AnimatedContainer(
                        duration: 300.ms,
                        height: 5,
                        width: tinkPage.value == 1 ? 25 : 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.5),
                          color: tinkPage.value == 1
                              ? const Color.fromRGBO(245, 247, 248, 1)
                              : const Color.fromRGBO(245, 247, 248, 0.30),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                IntrinsicWidth(
                  child: GestureDetector(
                    onTap: () {
                      if (tinkPage.value == 0) {
                        tinkPage.value = 1;
                        tinkController.animateTo(
                            MediaQuery.of(context).size.width,
                            duration: 300.ms,
                            curve: Curves.linear);
                      } else {
                        TinkStart.tinkDemoStop();
                        Get.offAll(() => TinkMainScreen());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: const Color.fromRGBO(255, 219, 39, 1),
                      ),
                      alignment: Alignment.center,
                      child: Obx(
                        () => Text(
                          tinkPage.value == 0 ? 'Continue' : 'Start',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(24, 24, 24, 1),
                          ),
                        ),
                      ),
                    ),
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
