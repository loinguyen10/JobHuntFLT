import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:riverpod/riverpod.dart';

import '../model/user.dart';

String BASE_URL = 'https://lmatmet1234.000webhostapp.com/JHTest/';
final _auth = FirebaseAuth.instance;
final fireStore = FirebaseFirestore.instance;
final fireStorage = FirebaseStorage.instance;

final emailLoginProvider = StateProvider((ref) => "");
final passwordLoginProvider = StateProvider((ref) => "");
final boolLoginProvider = StateProvider((ref) => false);
// final userLoginProvider = StateProvider<UserDetail?>((ref) => UserDetail());

final userLoginProvider = FutureProvider<UserDetail?>((ref) async {
  final email = ref.watch(emailLoginProvider);
  final pass = ref.watch(passwordLoginProvider);
  return login(email, pass);
});

// final loginCheckProvider = FutureProvider<bool>((ref) => login());

final listCompanyProvider =
    FutureProvider<List<CompanyInfo>>((ref) => getCompanyList());

Future<UserDetail?> login(String emailAddress, String password) async {
  final msg = jsonEncode({
    'email': 'casinnasstark@gmail.com',
    // 'email': emailAddress.trim(),
    'password': 'cstark',
    // 'password': password.trim(),
  });
  // Map<String, String> requestHeaders = {
  //   'Content-type': 'application/json',
  //   'Accept': 'application/json',
  // };
  Response response = await post(Uri.parse(BASE_URL + "user/login.php"),
      // headers: requestHeaders,
      body: msg);
  log('ket qua login00: ${response.statusCode}');
  log('ket qua login: ${jsonDecode(response.body)}');
  if (response.statusCode == 200) {
    final UserDetail result =
        UserDetail.fromJson(jsonDecode(response.body)['data']['user']);
    log("Token dc luu ${result.uid}");
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('uid', result.uid ?? '');
    // await prefs.setString('email', result.email ?? '');
    return result;
    //
  } else {
    Fluttertoast.showToast(
        msg: jsonDecode(response.body)['message'],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    return null;
  }
}

Future<List<CompanyInfo>> getCompanyList() async {
  QuerySnapshot xxx = await fireStore.collection('CompanyInfo').get();
  List<DocumentSnapshot> result = xxx.docs;
  List<CompanyInfo> list = [];

  for (final doc in result) {
    final data = doc.data() as Map<String, dynamic>;
    final company = CompanyInfo(
      accountId: data['accountId'],
      address: data['companyAddress'],
      avatar: data['companyAvatar'],
      description: data['companyDescription'],
      industry: data['companyIndustry'],
      name: data['companyName'],
      phone: data['companyPhone'],
      scale: data['companyScale'],
      website: data['companyWebsite'],
    );

    log('${company}');

    list.add(company);
  }

  return list;
}
