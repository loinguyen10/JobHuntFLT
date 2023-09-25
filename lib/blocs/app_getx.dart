import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/screen/home.dart';

import '../model/userprofile.dart';
import '../repository/repository.dart';

class InsideGetX extends GetxController {
  InsideService insideService = InsideService();

  RxString emailLogin = ''.obs;
  RxString passwordLogin = ''.obs;
  RxBool loginCheck = false.obs;

  RxBool darkCheck = false.obs;

  RxString avatarProfile = ''.obs;
  RxString cvProfile = ''.obs;
  RxString fullNameProfile = ''.obs;
  RxString displayNameProfile = ''.obs;
  RxString phoneProfile = ''.obs;
  RxString addressProfile = ''.obs;
  RxString birthdayProfile = ''.obs;
  RxString educationProfile = ''.obs;
  RxString minSalaryProfile = '0'.obs;
  RxString maxSalaryProfile = '0'.obs;
  RxString professionProfile = ''.obs;
  RxList listCompany = [].obs;
  Rx<UserProfileDetail> userProfile = UserProfileDetail().obs;
  Rx<UserDetail> userDetail = UserDetail().obs;
  RxList listEducation = [].obs;
  RxList listProfession = [].obs;
  Rx<EducationList> educationChoose = EducationList().obs;

  // RxString typeSalaryProfile = ''.obs;

  void getEmailLoginString(String email) {
    emailLogin.value = email;
  }

  void getPasswordLoginString(String password) {
    passwordLogin.value = password;
  }

  void checkDarkMode() {
    darkCheck.value = !darkCheck.value;
    Get.changeTheme(darkCheck.value ? ThemeData.light() : ThemeData.dark());
  }

  void getAvatarProfileString(String avatar) {
    avatarProfile.value = avatar;
  }

  void getCvProfileString(String cv) {
    cvProfile.value = cv;
  }

  void getFullNameProfileString(String fullname) {
    fullNameProfile.value = fullname;

    // if (displayNameProfile.isEmpty ||
    //     displayNameProfile.value == fullNameProfile.value) {
    //   displayNameProfile.value = fullname;
    // }

    // log('$fullname & ${displayNameProfile.value}');
  }

  void getDisplayNameProfileString(String displayName) {
    displayNameProfile.value = displayName;
  }

  // void getEmailProfileString(String email) {
  //   emailProfile.value = email;
  // }

  void getPhoneProfileString(String phone) {
    phoneProfile.value = phone;
  }

  void getAddressProfileString(String address) {
    addressProfile.value = address;
  }

  void getBirthdayProfileString(String birthday) {
    birthdayProfile.value = birthday;
  }

  void getEducationProfileString(EducationList education) {
    educationChoose.value = education;
    log('${educationChoose.value.title} : ${education.title}');
  }

  // void setEducationProfileNull() {
  //   educationChoose.close();
  //   log('close ${educationChoose.value.title}');
  // }

  void getMinSalaryProfileString(String min) {
    minSalaryProfile.value = min;

    if (int.parse(min) > int.parse(maxSalaryProfile.value)) {
      log('min error: $min > ${maxSalaryProfile.value}');
    }
  }

  void getMaxSalaryProfileString(String max) {
    maxSalaryProfile.value = max;

    if (int.parse(max) < int.parse(minSalaryProfile.value)) {
      log('max error: $max < ${minSalaryProfile.value}');
    }
  }

  Future<void> getCompanyList() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    listCompany.clear();

    List<DocumentSnapshot> result =
        await insideService.getCollection('CompanyInfo');

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

      listCompany.add(company);
    }

    log('${listCompany.length}');

    EasyLoading.dismiss();
  }

  Future<void> loginApp() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    // loginCheck = RxStatus.loading();
    // if (emailLogin.isNotEmpty && passwordLogin.isNotEmpty) {
    final user =
        await insideService.login(emailLogin.value, passwordLogin.value);
    if (user != null) {
      // loginCheck = RxStatus.success();
      loginCheck.value = true;
      userDetail.value = user;
    }
    // }
    // loginCheck.value = false;
    // loginCheck = RxStatus.empty();
    EasyLoading.dismiss();
  }

  Future<void> getEducationList() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    listEducation.clear();

    List<DocumentSnapshot> result =
        await insideService.getCollection('EducationList');
    for (final doc in result) {
      final data = doc.data() as Map<String, dynamic>;
      final education = EducationList(
        id: doc.id,
        title: data['title'],
      );
      listEducation.add(education);
      log('${education.id},${education.title}');
    }
    EasyLoading.dismiss();
  }

  Future<void> getProfessionList() async {
    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    listProfession.clear();

    List<DocumentSnapshot> result =
        await insideService.getCollection('ProfessionList');
    for (final doc in result) {
      final data = doc.data() as Map<String, dynamic>;
      final profession = EducationList(
        id: doc.id,
        title: data['title'],
      );
      listProfession.add(profession);
      log('$data');
    }
    EasyLoading.dismiss();
  }

//
}
