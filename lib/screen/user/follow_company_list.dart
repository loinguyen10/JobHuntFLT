import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/screen/user/company_information.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../component/card.dart';
import '../../value/keystring.dart';

class FollowCompanyScreen extends ConsumerWidget {
  const FollowCompanyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listYourFollowProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(Keystring.YOUR_FOLLOWING_COMPANY.tr),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),
                _data.when(
                  data: (data) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        String avatar = data[index].company!.avatarUrl ?? '';
                        String nameCompany =
                            data[index].company!.fullname ?? '';
                        String job = data[index].company!.job ?? '';
                        String level = data[index].company!.level ?? '';
                        var tag = job.split(',');
                        String province = getProvinceName(
                            data[index].company!.address!.substring(
                                data[index].company!.address!.lastIndexOf(',') +
                                    1),
                            ref);

                        return Card(
                          shadowColor: Colors.black,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          elevation: 5,
                          child: GestureDetector(
                              onTap: () {
                                ref.read(companyInforProvider.notifier).state =
                                    data[index].company!;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CompanyInformation()));
                              },
                              child: AppCompanyCard(
                                avatar: avatar,
                                name: nameCompany,
                                province: province,
                                job: tag[0],
                                level: level,
                              )),
                        );
                      },
                      itemCount: data.length,
                    );
                  },
                  error: (error, stackTrace) => SizedBox(
                    height: 160,
                    child: Center(
                      child: Text(Keystring.NO_DATA.tr),
                    ),
                  ),
                  loading: () => const SizedBox(
                    height: 160,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
// import 'package:jobhunt_ftl/screen/payment/payprocess.dart';
// import 'package:jobhunt_ftl/value/keystring.dart';
//
// import '../../value/style.dart';
//
// class Product {
//   String title;
//   int price;
//   int type;
//
//   Product({required this.title, required this.price, required this.type});
// }
//
// class payment_main_layout extends ConsumerWidget {
//   const payment_main_layout({super.key});
//
//   int calculatePrice(String timeUnit, Product product, int type) {
//     const daysInMonth = 30;
//     const daysInYear = 365;
//
//     double priceBF = 0;
//
//     switch (type) {
//       case 1:
//         priceBF = (product.price / daysInMonth);
//         break;
//       case 2:
//         priceBF = (product.price / (daysInMonth * 3));
//         break;
//       case 3:
//         priceBF = (product.price / (daysInMonth * 6));
//         break;
//       case 4:
//         priceBF = (product.price / daysInYear);
//         break;
//       default:
//         break;
//     }
//
//     return priceBF.toInt();
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     List<Product> itemsSize = [
//       Product(title: Keystring.Month.tr, price: 16000, type: 1),
//       Product(
//           title: Get.locale!.languageCode == 'en'
//               ? "3 ${Keystring.Month.tr}s"
//               : "3 ${Keystring.Month.tr}",
//           price: 40000,
//           type: 2),
//       Product(
//           title: Get.locale!.languageCode == 'en'
//               ? "6 ${Keystring.Month.tr}s"
//               : "6 ${Keystring.Month.tr}",
//           price: 72000,
//           type: 3),
//       Product(title: Keystring.YEAR.tr, price: 140000, type: 4),
//     ];
//
//     int selectedIdxSize = ref.watch(itemPayMentProvider);
//     bool isselectedIdxSize = ref.watch(isitemPayMentProvider);
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(Keystring.PAYMENT.tr),
//         backgroundColor: appPrimaryColor,
//         elevation: 0,
//         foregroundColor: Theme.of(context).colorScheme.background,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               Keystring.Update_account_line1.tr,
//               style: TextStyle(fontSize: 30),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               Keystring.Update_account_line2.tr,
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//           ),
//           Container(
//             height: 400,
//             padding: EdgeInsets.only(left: 5),
//             width: screenWidth,
//             child: ListView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: itemsSize.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     ref.read(itemPayMentProvider.notifier).state = index;
//                   },
//                   child: SizedBox(
//                     height: 84,
//                     width: screenWidth,
//                     child: Container(
//                       margin: EdgeInsets.only(left: 10, right: 10, top: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           width: 1.5,
//                           color: selectedIdxSize == index
//                               ? Colors.blue
//                               : Colors.grey,
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             flex: 3,
//                             child: SizedBox(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     '${NumberFormat("#,##0").format(itemsSize[index].price)} VND/${itemsSize[index].title}',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 25,
//                                     ),
//                                   ),
//                                   Text(
//                                     Keystring.ONLY.tr +
//                                         " " +
//                                         calculatePrice(
//                                             itemsSize[index].title,
//                                             itemsSize[index],
//                                             itemsSize[index].type)
//                                             .toString() +
//                                         " VND" +
//                                         '/' +
//                                         Keystring.DAY.tr,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: SizedBox(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   selectedIdxSize == index
//                                       ? Image.asset('assets/image/check.png')
//                                       : Container(
//                                     height: 24,
//                                     width: 24,
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       border: Border.all(
//                                         color: Colors.grey,
//                                         width: 2,
//                                       ),
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 15, right: 10),
//             height: 60,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: appPrimaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 minimumSize: Size(double.infinity, 60),
//               ),
//               onPressed: () {
//                 // Get the selected Product
//                 Product selectedProduct = itemsSize[selectedIdxSize];
//                 int Bundle_price = selectedProduct.price;
//                 String money = Bundle_price.toString();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => payprocess(money: money),
//                   ),
//                 );
//               },
//               child: Text(Keystring.Order.tr),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // ignore_for_file: prefer_const_constructors
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:jobhunt_ftl/screen/home.dart';
// import 'package:jobhunt_ftl/value/keystring.dart';
//
// import '../../component/home_button.dart';
//
// class ThankYouPage extends StatefulWidget {
//   const ThankYouPage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<ThankYouPage> createState() => _ThankYouPageState();
// }
//
// Color themeColor = const Color(0xFF43D19E);
//
// class _ThankYouPageState extends State<ThankYouPage> {
//   double screenWidth = 600;
//   double screenHeight = 400;
//   Color textColor = const Color(0xFF32567A);
//
//   @override
//   Widget build(BuildContext context) {
//     screenWidth = MediaQuery.of(context).size.width;
//     screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               height: 170,
//               padding: EdgeInsets.all(35),
//               decoration: BoxDecoration(
//                 color: themeColor,
//                 shape: BoxShape.circle,
//               ),
//               child: Image.asset(
//                 "assets/image/card.png",
//                 fit: BoxFit.contain,
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.1),
//             Text(
//               "Thank You!",
//               style: TextStyle(
//                 color: themeColor,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 36,
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.01),
//             Text(
//               Keystring.Payment_status1.tr,
//               style: TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 17,
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.05),
//             Text(
//               Keystring.Payment_status2.tr,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.black54,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 14,
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.06),
//             Flexible(
//               child: HomeButton(
//                 title: 'Home',
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => HomeScreen(),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
