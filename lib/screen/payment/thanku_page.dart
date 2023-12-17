import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/screen/home.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import '../../component/home_button.dart';

import 'dart:async';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  void initState() {
    super.initState();

    // Tự động chuyển về màn hình chính sau 5 giây
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 170,
                padding: EdgeInsets.all(35),
                decoration: BoxDecoration(
                  color: const Color(0xFF43D19E),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "assets/image/card.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
               Keystring.THANK_YOU.tr,
                style: TextStyle(
                  color: const Color(0xFF43D19E),
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                Keystring.Payment_status1.tr,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              // Flexible(
              //   child: HomeButton(
              //     title: 'Home',
              //     onTap: () {
              //       Navigator.pushReplacement(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => HomeScreen(),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

