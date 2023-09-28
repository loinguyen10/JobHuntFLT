import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/model/address.dart';

import '../model/company.dart';
import '../model/userprofile.dart';
import '../repository/repository.dart';
import '../screen/home.dart';
import 'app_riverpod_object.dart';

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

void resetCall(WidgetRef ref) {
  ref.read(userLoginProvider.notifier).state = null;
  ref.read(userProfileProvider.notifier).state = null;
  ref.read(companyProfileProvider.notifier).state = null;
  Get.offAll(HomeScreen());
}
