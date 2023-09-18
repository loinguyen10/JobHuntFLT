import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
import 'package:jobhunt_ftl/repository/repository.dart';
import 'package:riverpod/riverpod.dart';

import '../model/user.dart';

String BASE_URL = 'https://lmatmet1234.000webhostapp.com/JHTest/';
final _auth = FirebaseAuth.instance;
final fireStore = FirebaseFirestore.instance;
final fireStorage = FirebaseStorage.instance;
final InsideService insideService = InsideService();

final emailLoginProvider = StateProvider((ref) => "");
final passwordLoginProvider = StateProvider((ref) => "");

final userLoginProvider = StateProvider<UserDetail?>((ref) => UserDetail());

final authRepositoryProvider = Provider<InsideService>((ref) {
  return InsideService();
});

final userProfileProvider = FutureProvider<UserProfileDetail?>(
    (ref) => getUserProfile((ref.watch(userLoginProvider))!.uid ?? ''));

final listCompanyProvider =
    FutureProvider<List<CompanyInfo>>((ref) => getCompanyList());

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

Future<UserProfileDetail> getUserProfile(String uId) async {
  UserProfileDetail profile = UserProfileDetail();

  if (uId.isNotEmpty) {
    List<DocumentSnapshot> result1 =
        await insideService.getCollection('UserProfile');
    List<DocumentSnapshot> result2 =
        await insideService.getCollection('UserInfo');
    for (final doc1 in result1) {
      if (doc1.id == uId) {
        for (final doc2 in result2) {
          if (doc2.id == uId) {
            final data1 = doc1.data() as Map<String, dynamic>;
            final data2 = doc2.data() as Map<String, dynamic>;
            profile = UserProfileDetail(
              id: doc1.id,
              avatarUrl: data1['avatar'],
              cvUrl: data1['cv'],
              displayName: data2['name'],
              fullName: data2['name'],
              email: data2['email'],
              phone: data2['phone'],
              address: data2['address'],
              birthday: data2['birth'],
              education: [],
              maxSalary: data1['maxSalary'],
              minSalary: data1['minSalary'],
              profession: [],
              skillList: [],
              typeSalary: data1['typeSalary'],
            );
          }
        }
      }
    }
  }

  return profile;
}
