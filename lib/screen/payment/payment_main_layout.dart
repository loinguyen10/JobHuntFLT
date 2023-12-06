import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/screen/payment/payprocess.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../../value/style.dart';

class Product {
  String title;
  int price;
  int type;

  Product({required this.title, required this.price, required this.type});
}

class payment_main_layout extends ConsumerWidget {
  const payment_main_layout({super.key});

  int calculatePrice(String timeUnit, Product product, int type) {
    const daysInMonth = 30;
    const daysInYear = 365;

    double priceBF = 0;

    switch (type) {
      case 1:
        priceBF = (product.price / daysInMonth);
        break;
      case 2:
        priceBF = (product.price / (daysInMonth * 3));
        break;
      case 3:
        priceBF = (product.price / (daysInMonth * 6));
        break;
      case 4:
        priceBF = (product.price / daysInYear);
        break;
      default:
        break;
    }

    return priceBF.toInt();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Product> itemsSize = [
      Product(title: Keystring.Month.tr, price: 16000, type: 1),
      Product(
          title: Get.locale!.languageCode == 'en'
              ? "3 ${Keystring.Month.tr}s"
              : "3 ${Keystring.Month.tr}",
          price: 40000,
          type: 2),
      Product(
          title: Get.locale!.languageCode == 'en'
              ? "6 ${Keystring.Month.tr}s"
              : "6 ${Keystring.Month.tr}",
          price: 72000,
          type: 3),
      Product(title: Keystring.YEAR.tr, price: 140000, type: 4),
    ];

    int selectedIdxSize = ref.watch(itemPayMentProvider);
    bool isselectedIdxSize = ref.watch(isitemPayMentProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(Keystring.PAYMENT.tr),
        backgroundColor: appPrimaryColor,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              Keystring.Update_account_line1.tr,
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              Keystring.Update_account_line2.tr,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Container(
            height: 400,
            padding: EdgeInsets.only(left: 5),
            width: screenWidth,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: itemsSize.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    ref.read(itemPayMentProvider.notifier).state = index;
                  },
                  child: SizedBox(
                    height: 84,
                    width: screenWidth,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1.5,
                          color: selectedIdxSize == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${NumberFormat("#,##0").format(itemsSize[index].price)} VND/${itemsSize[index].title}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    Keystring.ONLY.tr +
                                        " " +
                                        calculatePrice(
                                                itemsSize[index].title,
                                                itemsSize[index],
                                                itemsSize[index].type)
                                            .toString() +
                                        " VND" +
                                        '/' +
                                        Keystring.DAY.tr,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  selectedIdxSize == index
                                      ? Image.asset('assets/image/check.png')
                                      : Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                            color: Colors.white,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 10),
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: appPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 60),
              ),
              onPressed: () {
                // Get the selected Product
                Product selectedProduct = itemsSize[selectedIdxSize];
                int Bundle_price = selectedProduct.price;
                String money = Bundle_price.toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => payprocess(money: money),
                  ),
                );
              },
              child: Text(Keystring.Order.tr),
            ),
          ),
        ],
      ),
    );
  }
}
