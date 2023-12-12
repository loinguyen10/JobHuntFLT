import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/screen/payment/Premium/premium.dart';
import 'package:jobhunt_ftl/screen/payment/thanku_page.dart';

import '../../blocs/app_controller.dart';
import '../../blocs/app_riverpod_object.dart';

class payprocess extends ConsumerWidget {
  final String money;

  // Constructor to receive the money value
  const payprocess({super.key, required this.money});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userLoginProvider);
    log("ac${money}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pay Screen"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
            "https://jobshunt.info/vnpay_php/vnpay_create_payment.php",
          ),
          method: 'POST',
          body: Uint8List.fromList(
            utf8.encode("amount=${money}&bankCode=&language=vn"),
          ),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
        onWebViewCreated: (controller) {
          debugPrint("Open web success");
        },
        onLoadStop: (controller, url) async {
          var uri = Uri.parse(url.toString());
            var queryParams = uri.queryParameters;
            var vnp_ResponseCode = queryParams['vnp_ResponseCode'];
            var vnp_CardType = queryParams['vnp_CardType'];
            log(queryParams.toString());
            var vnp_PayDate = queryParams['vnp_PayDate'];
            var vnp_Amount = queryParams['vnp_Amount'];
            var vnp_BankCode = queryParams['vnp_BankCode'];

            if (vnp_ResponseCode == '00') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThankYouPage(title: '',),
                ),
              );
              ref.read(LoginControllerProvider.notifier).addHistoryPayment(money, vnp_PayDate.toString(), vnp_ResponseCode.toString(), vnp_CardType.toString()+'-'+vnp_BankCode.toString(), user?.uid ??'',user?.role ?? '');
            }
        },
      ),
    );
  }
}
