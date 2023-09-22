import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jobhunt_ftl/model/address.dart';

import '../model/company.dart';
import '../model/userprofile.dart';
import '../repository/repository.dart';

String BASE_URL = 'https://lmatmet1234.000webhostapp.com/JHTest/';
final _auth = FirebaseAuth.instance;
final fireStore = FirebaseFirestore.instance;
final fireStorage = FirebaseStorage.instance;
final InsideService insideService = InsideService();

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

Future<List<EducationList>> getEducationList() async {
  final list = await insideService.getListEducation();
  log('list: ${list.length}');
  return list;
}

Future<List<ProvinceList>> getProvinceList() async {
  final list = await insideService.getListProvince();
  log('list: ${list.length}');
  return list;
}

Future<List<DistrictList>> getDistrictList() async {
  final list = await insideService.getListDistrict();
  log('list: ${list.length}');
  return list;
}

Future<List<WardList>> getWardList() async {
  final list = await insideService.getListWard();
  log('list: ${list.length}');
  return list;
}

Future<List<CurrencyList>> getCurrencyList() async {
  final list = await insideService.getListCurrency();
  log('list: ${list.length}');
  return list;
}
