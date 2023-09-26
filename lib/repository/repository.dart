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
import 'package:jobhunt_ftl/model/address.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/loader_overlay.dart';

String BASE_URL = 'https://jobshunt.info/app_auth/api/auth/';
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
      // 'email': 'laingu@jobshunt.info',
      // 'password': 'laicutai',
      // 'email': 'emminh@jobshunt.info',
      // 'password': 'minhhoang',
      'email': emailAddress.trim(),
      'password': password.trim(),
    });
    // Map<String, String> requestHeaders = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    // };
    Response response = await post(Uri.parse(BASE_URL + "login.php"),
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

  Future<dynamic> getListEducation() async {
    Response response =
        await get(Uri.parse(BASE_URL + "profile/education.php"));
    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['education'];
      log('$result');
      return result.map((e) => EducationList.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> getListCurrency() async {
    Response response = await get(Uri.parse(BASE_URL + "profile/currency.php"));
    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['currency'];
      return result.map((e) => CurrencyList.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> getListProvince() async {
    Response response = await get(Uri.parse(BASE_URL + "address/province.php"));
    if (response.statusCode == 200) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['province'];
      return result.map((e) => ProvinceList.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> getListDistrict() async {
    Response response = await get(Uri.parse(BASE_URL + "address/district.php"));
    if (response.statusCode == 200) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['district'];
      return result.map((e) => DistrictList.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> getListWard() async {
    Response response = await get(Uri.parse(BASE_URL + "address/ward.php"));
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))['data']['message']}');
    if (response.statusCode == 200) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['ward'];
      return result.map((e) => WardList.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> getProfile(String uid) async {
    final msg = jsonEncode({
      'uid': uid,
    });
    Response response =
        await post(Uri.parse(BASE_URL + "/profile/profile.php"), body: msg);
    if (response.statusCode == 200) {
      final UserProfileDetail result = UserProfileDetail.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes))['data']['profile']);
      return result;
    } else {
      return null;
    }
  }

  Future<dynamic> createProfile(
    String uid,
    String full_name,
    String avatar_url,
    String email,
    String phone,
    String address,
    String birthday,
    String educationId,
    String job,
    int minSalary,
    int maxSalary,
    String currency,
  ) async {
    final msg = jsonEncode({
      'uid': uid,
      'display_name': full_name,
      'full_name': full_name,
      'avatar_url': avatar_url,
      'email': email,
      'phone': phone,
      'address': address,
      'birthday': birthday,
      'educationId': educationId,
      'job': job,
      'level': 'Basic',
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'currency': currency
    });
    log('uid: $uid \n name: $full_name \n avatar: $avatar_url \n email: $email \n phone: $phone \n address: $address \n birth: $birthday \n educationId $educationId \n job: $job \n min: $minSalary \n max: $maxSalary \n currency: $currency ');

    Response response = await post(
        Uri.parse(BASE_URL + "/profile/create_profile.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> register(String emailAddress, String password) async {
    final msg = jsonEncode({
      'email': emailAddress.trim(),
      'password': password.trim(),
    });
    Response response =
        await post(Uri.parse(BASE_URL + "register.php"), body: msg);
    return jsonDecode(response.body)['success'];
  }
}
