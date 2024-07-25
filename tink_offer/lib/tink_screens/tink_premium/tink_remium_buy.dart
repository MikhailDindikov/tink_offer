import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_composite_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tink_offer/tink_controllers/tink_profile_controller.dart';

class TinkPremiumBuy extends StatefulWidget {
  const TinkPremiumBuy({super.key});

  @override
  State<TinkPremiumBuy> createState() => _TinkPremiumBuyState();
}

class _TinkPremiumBuyState extends State<TinkPremiumBuy> {
  final profileCt = Get.find<TinkProfileController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.only(
              top: 47,
              bottom: 30,
              left: 28,
              right: 28,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(36, 36, 36, 1),
              borderRadius: BorderRadius.circular(23),
            ),
            child: Column(
              children: [
                IntrinsicWidth(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromRGBO(255, 219, 39, 1),
                      ),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Premium',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(245, 247, 248, 1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Don’t miss your chance to plan your finance more comfy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Sarabun',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(142, 142, 147, 1),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                IntrinsicWidth(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(142, 142, 147, 0.25),
                        borderRadius: BorderRadius.circular(23)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'tassets/icons/done.svg',
                              height: 22,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'No Ads',
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(245, 247, 248, 1),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'tassets/icons/done.svg',
                              height: 22,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Private Notes',
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(245, 247, 248, 1),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'tassets/icons/done.svg',
                              height: 22,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Credentials',
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(245, 247, 248, 1),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                IntrinsicWidth(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromRGBO(255, 219, 39, 1),
                      ),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '4.99',
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(245, 247, 248, 1),
                            ),
                          ),
                          TextSpan(
                            text: '\$',
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(245, 247, 248, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                IntrinsicWidth(
                  child: GestureDetector(
                    onTap: () async {
                      if (!profileCt.profPremBuy.value) {
                        profileCt.profPremBuy.value = true;
                        final wwwwwwa = await Apphud.paywalls();
                        print(wwwwwwa?.paywalls.first.products!
                            .where((element) => element.productId == 'premium')
                            .toList()
                            .first);

                        final ananafna = await Apphud.purchase(
                          product: wwwwwwa?.paywalls.first.products!
                              .where((fodpofdopfd) =>
                                  fodpofdopfd.productId == 'premium')
                              .toList()
                              .first,
                        );
                        if (ananafna.error == null) {
                          profileCt.setProfPrem();
                        }

                        profileCt.profPremBuy.value = false;
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 36),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 219, 39, 1),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      alignment: Alignment.center,
                      child: Obx(
                        () => profileCt.profPremBuy.value
                            ? CupertinoActivityIndicator()
                            : Text(
                                'Get Premium',
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(24, 24, 24, 1),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                IntrinsicWidth(
                  child: GestureDetector(
                    onTap: () async {
                      if (!profileCt.profPremPurch.value) {
                        profileCt.profPremPurch.value = true;
                        final ApphudComposite restPud =
                            await Apphud.restorePurchases();

                        bool failPu = true;

                        if (restPud.purchases.isNotEmpty) {
                          for (final pu in restPud.purchases) {
                            if (pu.productId == 'premium') {
                              profileCt.setProfPrem();
                              break;
                            }
                          }
                        }

                        if (failPu) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color.fromRGBO(255, 219, 39, 1),
                              content: Text(
                                'Your purchase is not found!',
                                style: const TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(24, 24, 24, 1),
                                ),
                              ),
                            ),
                          );
                        }

                        profileCt.profPremPurch.value = false;
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 36),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 219, 39, 1),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      alignment: Alignment.center,
                      child: Obx(
                        () => profileCt.profPremPurch.value
                            ? CupertinoActivityIndicator()
                            : Text(
                                'Restore Purchase',
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
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
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
