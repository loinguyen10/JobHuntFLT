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
  // Future<dynamic> loginFirebase(String emailAddress, String password) async {
  //   try {
  //     final credential = await _auth.signInWithEmailAndPassword(
  //         email: emailAddress, password: password);
  //     final user = credential.user;
  //     return UserDetail(
  //         displayName: user?.displayName,
  //         email: user?.email,
  //         phoneNumber: user?.phoneNumber,
  //         photoURL: user?.photoURL,
  //         uid: user?.uid);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }

  Future<dynamic> login(String emailAddress, String password) async {
    // Loader.show(context);
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
    // String jsonBody = json.encode(body);
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
      Loader.hide();
      Fluttertoast.showToast(
          msg: jsonDecode(response.body)['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      throw Exception(response.reasonPhrase);
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
