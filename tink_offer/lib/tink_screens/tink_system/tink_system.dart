import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TinkSystem extends StatefulWidget {
  final String controllerWT;
  const TinkSystem({super.key, required this.controllerWT});

  @override
  State<TinkSystem> createState() => _TinkSystemState();
}

class _TinkSystemState extends State<TinkSystem> {
  late WebViewController controllerW;

  @override
  void initState() {
    String llllW = '';
    if (widget.controllerWT == 'Security Policy') {
      llllW =
          'https://docs.google.com/document/d/1cJ5St9T2COL_RzcFeZqvnVufDKuzxxMuPtgEEGWGdoY/edit?usp=sharing';
    } else if (widget.controllerWT == 'Terms of Use') {
      llllW =
          'https://docs.google.com/document/d/1hh2HyfOoKuyeV0RFtVkR8049wvJoyaZ8v8fE-NI9-cw/edit?usp=sharing';
    } else {
      llllW = 'https://sites.google.com/view/sherazshoukat/support-form';
    }

    controllerW = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(llllW));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 9, left: 16),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      CupertinoIcons.back,
                      color: Color.fromRGBO(245, 247, 248, 1),
                      size: 34,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.controllerWT,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Sarabun',
                      fontSize: 32,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(245, 247, 248, 1),
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0,
                  child: IgnorePointer(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: Get.back,
                      child: Icon(
                        CupertinoIcons.back,
                        color: Color.fromRGBO(24, 24, 24, 1),
                        size: 34,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(23),
                  child: WebViewWidget(
                    controller: controllerW,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
