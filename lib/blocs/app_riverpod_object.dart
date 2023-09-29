import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/model/address.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
import 'package:jobhunt_ftl/repository/repository.dart';
import 'package:riverpod/riverpod.dart';

import '../model/user.dart';
import 'app_riverpod_void.dart';

final emailLoginProvider = StateProvider((ref) => '');
final passwordLoginProvider = StateProvider((ref) => '');
final userLoginProvider = StateProvider<UserDetail?>((ref) => UserDetail());
final userProfileProvider =
    StateProvider<UserProfileDetail?>((ref) => UserProfileDetail());

final companyProfileProvider =
    StateProvider<CompanyDetail?>((ref) => CompanyDetail());

final checkboxTermProvider = StateProvider.autoDispose((ref) => false);

final authRepositoryProvider = Provider<InsideService>((ref) {
  return InsideService();
});

final listJobProvider =
    FutureProvider<List<CompanyInfo>>((ref) => getJobList());

final listCompanyProvider =
    FutureProvider<List<CompanyDetail>>((ref) => getCompanyList());

final listEducationProvider =
    FutureProvider<List<EducationList>>((ref) => getEducationList());

final listProvinceProvider =
    FutureProvider<List<ProvinceList>>((ref) => getProvinceList());

final listDistrictProvider =
    FutureProvider<List<DistrictList>>((ref) => getDistrictList());

final listWardProvider = FutureProvider<List<WardList>>((ref) => getWardList());
final listCurrencyProvider =
    FutureProvider<List<CurrencyList>>((ref) => getCurrencyList());

//userProfile
final avatarProfileProvider =
    StateProvider((ref) => ref.watch(userProfileProvider)?.avatarUrl ?? "");

final cvUploadProvider =
    StateProvider((ref) => ref.watch(userProfileProvider)?.cvUrl ?? "");

final fullNameProfileProvider =
    StateProvider((ref) => ref.watch(userProfileProvider)?.fullName ?? "");

final emailProfileProvider = StateProvider((ref) =>
    ref.watch(userProfileProvider)?.email ??
    ref.watch(emailLoginProvider) ??
    '');

final phoneProfileProvider =
    StateProvider((ref) => ref.watch(userProfileProvider)?.phone ?? "");

final jobProfileProvider =
    StateProvider((ref) => ref.watch(userProfileProvider)?.job ?? "");

final dateBirthProvider = StateProvider.autoDispose(
    (ref) => ref.watch(userProfileProvider)?.birthday ?? "");

final minSalaryProvider =
    StateProvider<int>((ref) => ref.watch(userProfileProvider)?.minSalary ?? 0);

final maxSalaryProvider =
    StateProvider<int>((ref) => ref.watch(userProfileProvider)?.maxSalary ?? 0);

final educationChooseProvider =
    StateProvider<EducationList?>((ref) => EducationList());

final provinceChooseProvider = StateProvider.autoDispose<ProvinceList?>((ref) {
  if (ref.watch(userProfileProvider) != null &&
      !ref.watch(listProvinceProvider).isLoading) {
    var list = ref.watch(listProvinceProvider).value;
    for (var x in list!) {
      var address = ref.watch(userProfileProvider)?.address;
      if (address?.substring(address.lastIndexOf(',') + 1) == x.code) {
        return x;
      }
    }
  }
  return ProvinceList();
});

final districtChooseProvider = StateProvider.autoDispose<DistrictList?>((ref) {
  if (ref.watch(userProfileProvider) != null &&
      !ref.watch(listDistrictProvider).isLoading) {
    var list = ref.watch(listDistrictProvider).value;
    for (var x in list!) {
      var address = ref.watch(userProfileProvider)?.address;
      if (address?.substring(
              address.lastIndexOf(',', address.lastIndexOf(',') - 1) + 1,
              address.lastIndexOf(',')) ==
          x.code) {
        return x;
      }
    }
  }
  return DistrictList();
});

final wardChooseProvider = StateProvider.autoDispose<WardList?>((ref) {
  if (ref.watch(userProfileProvider) != null &&
      !ref.watch(listWardProvider).isLoading) {
    var list = ref.watch(listWardProvider).value;
    var address = ref.watch(userProfileProvider)?.address;

    for (var x in list!) {
      if (address?.substring(address.indexOf(',') + 1,
              address.indexOf(',', address.indexOf(',') + 1)) ==
          x.code) {
        return x;
      }
    }
  }
  return WardList();
});

final currencyChooseProvider = StateProvider.autoDispose<CurrencyList?>((ref) {
  if (ref.watch(userProfileProvider) != null &&
      !ref.watch(listCurrencyProvider).isLoading) {
    var list = ref.watch(listCurrencyProvider).value;
    var currency = ref.watch(userProfileProvider)?.currency;

    for (var x in list!) {
      if (currency == x.code) {
        return x;
      }
    }
  }
  return CurrencyList();
});

final listEducationShowProvider = StateProvider<List<EducationList>>((ref) {
  if (ref.watch(userProfileProvider) != null) {
    var education = ref.watch(userProfileProvider)?.education;
    return [...education!];
  }
  return [];
});

//company
final avatarCompanyProvider =
    StateProvider((ref) => ref.watch(companyProfileProvider)?.avatarUrl ?? "");

final fullNameCompanyProvider =
    StateProvider((ref) => ref.watch(companyProfileProvider)?.fullname ?? "");

final emailCompanyProvider = StateProvider((ref) =>
    ref.watch(companyProfileProvider)?.email ??
    ref.watch(emailLoginProvider) ??
    '');

final websiteCompanyProvider =
    StateProvider((ref) => ref.watch(companyProfileProvider)?.phone ?? "");

final phoneCompanyProvider =
    StateProvider((ref) => ref.watch(companyProfileProvider)?.phone ?? "");

final provinceCompanyProvider = StateProvider.autoDispose<ProvinceList?>((ref) {
  if (ref.watch(companyProfileProvider) != null &&
      !ref.watch(listProvinceProvider).isLoading) {
    var list = ref.watch(listProvinceProvider).value;
    for (var x in list!) {
      var address = ref.watch(companyProfileProvider)?.address;
      if (address?.substring(address.lastIndexOf(',') + 1) == x.code) {
        return x;
      }
    }
  }
  return ProvinceList();
});

final districtCompanyProvider = StateProvider.autoDispose<DistrictList?>((ref) {
  if (ref.watch(companyProfileProvider) != null &&
      !ref.watch(listDistrictProvider).isLoading) {
    var list = ref.watch(listDistrictProvider).value;
    for (var x in list!) {
      var address = ref.watch(companyProfileProvider)?.address;
      if (address?.substring(
              address.lastIndexOf(',', address.lastIndexOf(',') - 1) + 1,
              address.lastIndexOf(',')) ==
          x.code) {
        return x;
      }
    }
  }
  return DistrictList();
});

final wardCompanyProvider = StateProvider.autoDispose<WardList?>((ref) {
  if (ref.watch(companyProfileProvider) != null &&
      !ref.watch(listWardProvider).isLoading) {
    var list = ref.watch(listWardProvider).value;
    var address = ref.watch(companyProfileProvider)?.address;

    for (var x in list!) {
      if (address?.substring(address.indexOf(',') + 1,
              address.indexOf(',', address.indexOf(',') + 1)) ==
          x.code) {
        return x;
      }
    }
  }
  return WardList();
});

final roadCompanyProvider = StateProvider((ref) =>
    ref.watch(companyProfileProvider)?.address?.substring(
        0, ref.watch(companyProfileProvider)?.address?.indexOf(',')) ??
    "");

final descriptionCompanyProvider = StateProvider(
    (ref) => ref.watch(companyProfileProvider)?.description ?? "");

final jobCompanyProvider =
    StateProvider((ref) => ref.watch(companyProfileProvider)?.job ?? "");
