import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:jobhunt_ftl/model/address.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
import 'package:jobhunt_ftl/repository/repository.dart';
import 'package:riverpod/riverpod.dart';

import '../model/user.dart';
import 'app_riverpod_void.dart';

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

final listEducationProvider =
    FutureProvider<List<EducationList>>((ref) => getEducationList());

final listProvinceProvider =
    FutureProvider<List<ProvinceList>>((ref) => getProvinceList());

final listDistrictProvider =
    FutureProvider<List<DistrictList>>((ref) => getDistrictList());

final listWardProvider = FutureProvider<List<WardList>>((ref) => getWardList());

final educationChooseProvider =
    StateProvider<EducationList?>((ref) => EducationList());

final provinceChooseProvider =
    StateProvider<ProvinceList?>((ref) => ProvinceList());

final districtChooseProvider =
    StateProvider<DistrictList?>((ref) => DistrictList());

final wardChooseProvider = StateProvider<WardList?>((ref) => WardList());
