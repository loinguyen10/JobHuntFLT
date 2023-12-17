import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/screen/home.dart';
import 'package:jobhunt_ftl/value/keystring.dart';


class ThankYouPage1 extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
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
                "Thank You!",
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
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
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
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
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
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ), SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                Keystring.Payment_status2.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
