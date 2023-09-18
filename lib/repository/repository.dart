import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/loader_overlay.dart';

String BASE_URL = 'https://lmatmet1234.000webhostapp.com/JHTest/';
final _auth = FirebaseAuth.instance;
final fireStore = FirebaseFirestore.instance;
final fireStorage = FirebaseStorage.instance;

class InsideService {
  InsideService();

  // Stream<User?> get authStateChange => _auth.idTokenChanges();

  // Future<dynamic> loginFirebase(String emailAddress, String password) async {
  //   try {
  //     final credential = await _auth.signInWithEmailAndPassword(
  //         email: emailAddress, password: password);
  //     final user = credential.user;
  //     log('user :$user');
  //     // return UserDetail(email: user?.email, uid: user?.uid);
  //     return user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       throw 'No user found for that email.';
  //     } else if (e.code == 'wrong-password') {
  //       throw 'Wrong password provided for that user.';
  //     } else {
  //       throw 'Wrong.';
  //     }
  //   }
  // }

  Future<dynamic> login(String emailAddress, String password) async {
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', result.uid ?? '');
      await prefs.setString('email', result.email ?? '');
      return result;
    } else {
      return null;
      // Fluttertoast.showToast(
      //     msg: jsonDecode(response.body)['message'],
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }

  Future<dynamic> getCollection(String collection) async {
    QuerySnapshot xxx = await fireStore.collection(collection).get();
    return xxx.docs;
  }

  Future<dynamic> uploadPdfStorage(File file, String uid) async {
    final storageRef = fireStorage.ref();

    final ref = storageRef.child("cv/" + uid + ".pdf");

    ref.putFile(file);

    final imageUrl = await ref.getDownloadURL();

    return imageUrl;
  }
}
