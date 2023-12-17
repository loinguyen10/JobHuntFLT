import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart';
import 'package:jobhunt_ftl/model/address.dart';
import 'package:jobhunt_ftl/model/application.dart';
import 'package:jobhunt_ftl/model/cv.dart';
import 'package:jobhunt_ftl/model/favorite.dart';
import 'package:jobhunt_ftl/model/follow.dart';
import 'package:jobhunt_ftl/model/job.dart';
import 'package:jobhunt_ftl/model/payment.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../model/company.dart';
import '../model/job_setting.dart';
import '../repository/repository.dart';
import 'app_riverpod_object.dart';

final _auth = FirebaseAuth.instance;
final fireStore = FirebaseFirestore.instance;
final fireStorage = FirebaseStorage.instance;
final InsideService insideService = InsideService();

Future<List<CompanyInfo>> getCVList() async {
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
  ref.invalidate(userLoginProvider);
  ref.invalidate(userProfileProvider);
  ref.invalidate(companyProfileProvider);
  ref.invalidate(userDetailJobSettingProvider);
}

Future<List<CompanyDetail>> getCompanyList() async {
  final list = await insideService.getListCompany();
  log('list: ${list.length}');
  return list;
}

String convertJpg(String filePath) {
  final filePath2 = filePath.substring(0, filePath.lastIndexOf('.')) + '.jpg';
  final image = decodeImage(File(filePath).readAsBytesSync());
  final thumbnail = copyResize(image!, width: 256, height: 256);
  File(filePath2)..writeAsBytesSync(encodePng(thumbnail));
  log(filePath2);
  return filePath2;
}

String getProvinceName(String code, WidgetRef ref) {
  String name = '';
  ref.watch(listProvinceProvider).when(
        data: (_data) {
          for (var i in _data) {
            if (code == i.code) name = i.name ?? '';
          }
        },
        error: (error, stackTrace) => (),
        loading: () => (),
      );
  return name;
}

String getDistrictName(String code, WidgetRef ref) {
  String name = '';
  ref.watch(listDistrictProvider).when(
        data: (_data) {
          for (var i in _data) {
            if (code == i.code) {
              if (Get.locale!.languageCode == 'vi') {
                name = i.fullName ?? '';
              }
              if (Get.locale!.languageCode == 'en') {
                name = i.name ?? '';
              }
              break;
            }
          }
        },
        error: (error, stackTrace) => (),
        loading: () => (),
      );
  return name;
}

String getWardName(String code, WidgetRef ref) {
  String name = '';
  ref.watch(listWardProvider).when(
        data: (_data) {
          for (var i in _data) {
            if (code == i.code) {
              if (Get.locale!.languageCode == 'vi') {
                name = i.fullName ?? '';
              }
              if (Get.locale!.languageCode == 'en') {
                name = i.name ?? '';
              }
              break;
            }
          }
        },
        error: (error, stackTrace) => (),
        loading: () => (),
      );
  return name;
}

String getReduceZeroMoney(int money) {
  String reduce = money.toString();

  switch (money) {
    case >= 1000 && <= 9 * 100000:
      reduce =
          "${(money / 1000).toStringAsFixed(money % 1000000 == 0 ? 0 : 1)} ${Keystring.THOUSANDS.tr}";
      break;
    case >= 1000000 && <= 9 * 100000000:
      reduce =
          "${(money / 1000000).toStringAsFixed(money % 1000000 == 0 ? 0 : 1)} ${Keystring.MILLIONS.tr}";
      break;
    case >= 1000000000:
      reduce =
          "${(money / 1000000000).toStringAsFixed(money % 1000000 == 0 ? 0 : 1)} ${Keystring.BILLIONS.tr}";
      break;
  }
  return reduce;
}

bool checkPassword(String password) {
  bool check = true;
  bool count = false;
  String mess = Keystring.PASSWORD.tr;

  if (password.trim().isEmpty) {
    check = false;
    mess = Keystring.PLS_ENTER_PASSWORD.tr;
  } else {
    if (password.trim().length < 6) {
      check = false;
      mess += ' ${Keystring.NEED_6P_CHAR.tr.toLowerCase()}';
      count = true;
    }
    if (password.trim().contains(' ')) {
      check = false;
      if (count) mess += " ${Keystring.AND.tr.toLowerCase()}";
      mess += ' ${Keystring.NO_SPACE.tr.toLowerCase()}';
    }
  }

  if (!check) {
    Fluttertoast.showToast(
        msg: "$mess.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  return check;
}

Future<List<JobDetail>> getJobList() async {
  final list = await insideService.getListJob();
  log('list job: ${list.length}');
  return list;
}

Future<List<JobDetail>> getPostedJobList(String companyId) async {
  final list = await insideService.getListJob();
  List<JobDetail> yourJob = [];

  for (var i in list) {
    if (companyId == i.companyId) yourJob.add(i);
  }

  return yourJob;
}

Future<List<JobDetail>> getSuggestionJobList(String companyId) async {
  final list = await insideService.getListJob();
  List<JobDetail> yourJob = [];

  for (var i in list) {
    if (companyId == i.companyId && i.active == 1) yourJob.add(i);
  }

  return yourJob;
}

Future<List<JobDetail>> getActiveJobList() async {
  final list = await insideService.getListJobActive();
  return list;
}

Future<List<JobDetail>> getRecommendJobList(String uid) async {
  if (uid == '0') return [];
  final list = await insideService.getJobsRecommend(uid);
  return list;
}

Future<List<CVDetail>> getYourCVList(String userId) async {
  final list = await insideService.getListCV();
  List<CVDetail> yourCV = [];

  for (var i in list) {
    if (userId == i.userId) yourCV.add(i);
  }

  return yourCV;
}

Future<List<CVDetail>> getAllCVList() async {
  final list = await insideService.getListCV();
  return list;
}

Future<List<FavoriteDetail>> getYourFavoriteList(String uid) async {
  final list = await insideService.getListFavorite(uid);
  return list;
}

Future<List<ApplicationDetail>> getCandidateApplication(
    String candidateId) async {
  final list = await insideService.getCandidateApplication(candidateId);
  return list;
}

Future<List<ApplicationDetail>> getRecuiterApplication(
  String recuiterId,
  String searchWord,
  String approve,
  String sentTime,
) async {
  final list = await insideService.getRecuiterApplication(
    recuiterId,
    searchWord,
    approve,
    sentTime,
  );
  return list;
}

Future<List<String>> getAllJobTitle() async {
  final list = await insideService.getAllJobTitle();
  return list;
}

//
Future<List<FollowDetail>> getYourFollowList(String uid) async {
  final list = await insideService.getListFollow(uid);
  return list;
}

Future<List<CompanyDetail>> getCompanyListUid(String uid) async {
  final list = await insideService.getCompany(uid);
  log('list: ${list.length}');
  return list;
}

Future<List<UserProfileDetail>> getUserProfileList() async {
  final list = await insideService.getListUserProfile();
  log('listProfile: ${list.length}');
  return list;
}

Future<List<PaymentDetail>> getYourHistoryPaymentList(String uid) async {
  final list = await insideService.getListHistoryPayments(uid);
  return list;
}

void getCandidateRecommend(String uid, WidgetRef ref) async {
  final result = await insideService.getJobRecommendSetting(uid);
  ref.read(candidateRecommendProvider.notifier).state = result;
}
