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
import 'package:intl/intl.dart';
import 'package:jobhunt_ftl/model/address.dart';
import 'package:jobhunt_ftl/model/application.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/model/cv.dart';
import 'package:jobhunt_ftl/model/favorite.dart';
import 'package:jobhunt_ftl/model/job.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/loader_overlay.dart';

String BASE_URL = 'https://jobshunt.info/app_auth/api/auth/';
String BASE_IMG_URL = 'https://jobshunt.info/app_auth/img/';
String BASE_CV_URL = 'https://jobshunt.info/app_auth/cv/';
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
      // 'email': 'hungbip@jobshunt.info',
      // 'password': 'hung',
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

  Future<dynamic> getCompany(String uid) async {
    final msg = jsonEncode({
      'uid': uid,
    });
    Response response =
        await post(Uri.parse(BASE_URL + "/company/company.php"), body: msg);
    if (response.statusCode == 200) {
      final CompanyDetail result = CompanyDetail.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes))['data']['company']);
      return result;
    } else {
      return null;
    }
  }

  Future<dynamic> createCompany(
    String uid,
    String full_name,
    String avatar_url,
    String email,
    String phone,
    String address,
    String website,
    String description,
    String job,
  ) async {
    final msg = jsonEncode({
      'uid': uid,
      'full_name': full_name,
      'avatar_url': avatar_url,
      'email': email,
      'phone': phone,
      'address': address,
      'web': website,
      'description': description,
      'job': job,
      'level': 'Basic',
    });
    log('uid: $uid \n name: $full_name \n avatar: $avatar_url \n email: $email \n phone: $phone \n address: $address \n website: $website \n description $description \n job: $job ');

    Response response = await post(
        Uri.parse(BASE_URL + "/company/create_company.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> updateProfile(
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
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'currency': currency
    });
    log('uid: $uid \n name: $full_name \n avatar: $avatar_url \n email: $email \n phone: $phone \n address: $address \n birth: $birthday \n educationId $educationId \n job: $job \n min: $minSalary \n max: $maxSalary \n currency: $currency ');

    Response response = await post(
        Uri.parse(BASE_URL + "/profile/update_profile.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> updateCompany(
    String uid,
    String full_name,
    String avatar_url,
    String email,
    String phone,
    String address,
    String website,
    String description,
    String job,
  ) async {
    final msg = jsonEncode({
      'uid': uid,
      'full_name': full_name,
      'avatar_url': avatar_url,
      'email': email,
      'phone': phone,
      'address': address,
      'web': website,
      'description': description,
      'job': job,
    });
    log('uid: $uid \n name: $full_name \n avatar: $avatar_url \n email: $email \n phone: $phone \n address: $address \n website: $website \n description $description \n job: $job ');

    Response response = await post(
        Uri.parse(BASE_URL + "/company/update_company.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> getListCompany() async {
    Response response =
        await get(Uri.parse(BASE_URL + "company/allCompany.php"));
    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['company'];
      return result.map((e) => CompanyDetail.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> createJob(
    String name,
    String companyId,
    int minSalary,
    int maxSalary,
    String currency,
    int yearExperience,
    int typeJob,
    int numberCandidate,
    String address,
    String description,
    String candidateRequirement,
    String jobBenefit,
    String tag,
    String deadline,
    int active,
  ) async {
    final msg = jsonEncode({
      'name': name,
      'companyId': companyId,
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'currency': currency,
      'yearExperience': yearExperience,
      'typeJob': typeJob,
      'numberCandidate': numberCandidate,
      'address': address,
      'description': description,
      'candidateRequirement': candidateRequirement,
      'jobBenefit': jobBenefit,
      'tag': tag,
      'deadline': deadline,
      'active': active,
      'level': 'Basic',
    });
    log('name: $name\n companyId: $companyId\n minSalary: $minSalary\n maxSalary: $maxSalary\ncurrency: $currency\nyearExperience: $yearExperience\ntypeJob: $typeJob\nnumberCandidate: $numberCandidate\naddress: $address\ndescription: $description\ncandidateRequirement: $candidateRequirement\njobBenefit: $jobBenefit\ntag: $tag\ndeadline: $deadline\nactive: $active');

    Response response =
        await post(Uri.parse(BASE_URL + "/job/create_job.php"), body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> updateJob(
    String code,
    String name,
    String companyId,
    int minSalary,
    int maxSalary,
    String currency,
    int yearExperience,
    int typeJob,
    int numberCandidate,
    String address,
    String description,
    String candidateRequirement,
    String jobBenefit,
    String tag,
    String deadline,
    int active,
  ) async {
    final msg = jsonEncode({
      'code': code,
      'name': name,
      'companyId': companyId,
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'currency': currency,
      'yearExperience': yearExperience,
      'typeJob': typeJob,
      'numberCandidate': numberCandidate,
      'address': address,
      'description': description,
      'candidateRequirement': candidateRequirement,
      'jobBenefit': jobBenefit,
      'tag': tag,
      'deadline': deadline,
      'active': active,
      'level': 'Basic',
    });
    log('code: $code\n name: $name\n companyId: $companyId\n minSalary: $minSalary\n maxSalary: $maxSalary\ncurrency: $currency\nyearExperience: $yearExperience\ntypeJob: $typeJob\nnumberCandidate: $numberCandidate\naddress: $address\ndescription: $description\ncandidateRequirement: $candidateRequirement\njobBenefit: $jobBenefit\ntag: $tag\ndeadline: $deadline\nactive: $active');

    Response response =
        await post(Uri.parse(BASE_URL + "/job/update_job.php"), body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> getJob(String code) async {
    final msg = jsonEncode({
      'code': code,
    });
    Response response =
        await post(Uri.parse(BASE_URL + "/job/job.php"), body: msg);
    if (response.statusCode == 200) {
      final JobDetail result = JobDetail.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes))['data']['job']);
      return result;
    } else {
      return null;
    }
  }

  Future<dynamic> getListJob() async {
    Response response = await get(Uri.parse(BASE_URL + "job/allJob.php"));
    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['job'];
      return result.map((e) => JobDetail.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> addCV(
    String cv,
    String userId,
    String type,
  ) async {
    final msg = jsonEncode({
      'cv_url': cv,
      'user_id': userId,
      'type': type,
      'create_date': DateFormat('dd/MM/yyyy').add_Hm().format(DateTime.now()),
    });
    log('cv: $cv\n userid: $userId\n type: $type');

    Response response =
        await post(Uri.parse(BASE_URL + "/cv/create_cv.php"), body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> getListCV() async {
    Response response = await get(Uri.parse(BASE_URL + "cv/allCV.php"));
    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['cv'];
      return result.map((e) => CVDetail.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> addFavorite(
    String jobId,
    String userId,
  ) async {
    final msg = jsonEncode({
      'jobId': jobId,
      'userId': userId,
    });

    Response response = await post(
        Uri.parse(BASE_URL + "/profile/add_favorive.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> removeFavorite(
    String jobId,
    String userId,
  ) async {
    final msg = jsonEncode({
      'jobId': jobId,
      'userId': userId,
    });

    Response response = await post(
        Uri.parse(BASE_URL + "/profile/remove_favorive.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> getListFavorite(String userId) async {
    final msg = jsonEncode({
      'userId': userId,
    });
    Response response = await post(
        Uri.parse(BASE_URL + "profile/your_favorite.php"),
        body: msg);

    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['favorite'];
      return result.map((e) => FavoriteDetail.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> createApplication(
    String cv_url,
    String jobId,
    String candidateId,
    String companyId,
  ) async {
    final msg = jsonEncode({
      'cv_url': cv_url,
      'jobId': jobId,
      'candidateId': candidateId,
      'companyId': companyId,
      'send_time': DateFormat('dd/MM/yyyy').add_Hm().format(DateTime.now()),
    });

    Response response = await post(
        Uri.parse(BASE_URL + "/application/create_application.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> removeApplication(
    String code,
  ) async {
    final msg = jsonEncode({
      'code': code,
    });

    Response response = await post(
        Uri.parse(BASE_URL + "/application/remove_application.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> apporveApplication(
    String code,
    String apporve,
  ) async {
    final msg = jsonEncode({
      'code': code,
      'apporve': apporve,
      'apporve_time': DateFormat('dd/MM/yyyy').add_Hm().format(DateTime.now()),
    });

    Response response = await post(
        Uri.parse(BASE_URL + "/application/apporve_application.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> getCandidateApplication(String candidateId) async {
    final msg = jsonEncode({
      'candidateId': candidateId,
    });

    Response response = await post(
      Uri.parse(BASE_URL + "application/candidate_application.php"),
      body: msg,
    );

    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['application'];
      return result.map((e) => ApplicationDetail.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> getRecuiterApplication(String companyId) async {
    final msg = jsonEncode({
      'companyId': companyId,
    });

    Response response = await post(
      Uri.parse(BASE_URL + "application/recuiter_application.php"),
      body: msg,
    );

    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['application'];
      return result.map((e) => ApplicationDetail.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> sendOTPtoMail(
    String mail,
  ) async {
    final msg = jsonEncode({
      'email': mail,
      'type_code': 'RePassOTP',
    });

    Response response =
        await post(Uri.parse(BASE_URL + "/code/api_verifycode.php"), body: msg);
    log('${jsonDecode(response.body)}a');
    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> checkOTP(
    String otp,
    String mail,
  ) async {
    final msg = jsonEncode({
      'email': mail,
      'otp_code': otp,
      'type_code': 'RePassOTP',
    });

    Response response = await post(
        Uri.parse(BASE_URL + "/code/api_confirmcode.php"),
        body: msg);
    log('${jsonDecode(response.body)}a');
    return jsonDecode(response.body)['success'];
  }

    Future<dynamic> newPass(
    String password,
    String mail,
  ) async {
    final msg = jsonEncode({
      'email': mail,
      'new_password': password,
    });

    Response response = await post(
        Uri.parse(BASE_URL + "/update_password.php"),
        body: msg);
    log('${jsonDecode(response.body)}a');
    return jsonDecode(response.body)['success'];
  }
}

