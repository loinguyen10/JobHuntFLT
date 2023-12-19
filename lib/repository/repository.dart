import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:jobhunt_ftl/model/address.dart';
import 'package:jobhunt_ftl/model/application.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/model/cv.dart';
import 'package:jobhunt_ftl/model/favorite.dart';
import 'package:jobhunt_ftl/model/follow.dart';
import 'package:jobhunt_ftl/model/job.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/job_setting.dart';
import '../model/payment.dart';
import '../value/style.dart';

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
  //     } else {p;
  //       throw 'Wrong.';
  //     }
  //   }
  // }

  Future<dynamic> login(String emailAddress, String password) async {
    final msg = jsonEncode({
      // 'email': 'laingu@jobshunt.info',
      // 'password': 'laicutai',
      // 'email': 'dohonghai252003@gmail.com',
      // 'password': '123456',
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
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
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
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
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
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['currency'];
      return result.map((e) => CurrencyList.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> getListProvince() async {
    Response response = await get(Uri.parse(BASE_URL + "address/province.php"));
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['province'];
      return result.map((e) => ProvinceList.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> getListDistrict() async {
    Response response = await get(Uri.parse(BASE_URL + "address/district.php"));
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
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
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
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
        await post(Uri.parse(BASE_URL + "profile/profile.php"), body: msg);
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
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
      'level': 'Basic',
    });
    log('uid: $uid \n name: $full_name \n avatar: $avatar_url \n email: $email \n phone: $phone \n address: $address \n birth: $birthday \n ');

    Response response = await post(
        Uri.parse(BASE_URL + "profile/create_profile.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> register(String emailAddress, String password) async {
    final msg = jsonEncode({
      'email': emailAddress.trim().toLowerCase(),
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
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
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
    String taxcode,
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
      'tax_code': taxcode.trim(),
      'description': description,
      'job': job,
      'level': 'Basic',
    });
    log('uid: $uid \n name: $full_name \n avatar: $avatar_url \n email: $email \n phone: $phone \n address: $address \n website: $website \n description $description \n job: $job \n taxcode: $taxcode ');

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
    });
    log('uid: $uid \n name: $full_name \n avatar: $avatar_url \n email: $email \n phone: $phone \n address: $address \n birth: $birthday \n');

    Response response = await post(
        Uri.parse(BASE_URL + "profile/update_profile.php"),
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
    String taxcode,
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
      'tax_code': taxcode.trim(),
      'description': description,
      'job': job,
    });
    log('uid: $uid \n name: $full_name \n avatar: $avatar_url \n email: $email \n phone: $phone \n address: $address \n website: $website \n description $description \n job: $job \n taxcode: $taxcode ');

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
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
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
      'currency': 'VND',
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
    log('name: $name\n companyId: $companyId\n minSalary: $minSalary\n maxSalary: $maxSalary\nyearExperience: $yearExperience\ntypeJob: $typeJob\nnumberCandidate: $numberCandidate\naddress: $address\ndescription: $description\ncandidateRequirement: $candidateRequirement\njobBenefit: $jobBenefit\ntag: $tag\ndeadline: $deadline\nactive: $active');

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
      'currency': 'VND',
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
    log('code: $code\n name: $name\n companyId: $companyId\n minSalary: $minSalary\n maxSalary: $maxSalary\nyearExperience: $yearExperience\ntypeJob: $typeJob\nnumberCandidate: $numberCandidate\naddress: $address\ndescription: $description\ncandidateRequirement: $candidateRequirement\njobBenefit: $jobBenefit\ntag: $tag\ndeadline: $deadline\nactive: $active');

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
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
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
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
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
      'create_time': DateFormat('dd/MM/yyyy').add_Hm().format(DateTime.now()),
    });
    log('cv: $cv\n userid: $userId\n type: $type');

    Response response =
        await post(Uri.parse(BASE_URL + "cv/create_cv.php"), body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> getListCV() async {
    Response response = await get(Uri.parse(BASE_URL + "cv/allCV.php"));
    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
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

    Response response =
        await post(Uri.parse(BASE_URL + "profile/add_favorive.php"), body: msg);

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
        Uri.parse(BASE_URL + "profile/remove_favorive.php"),
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
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
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

  Future<dynamic> approveApplication(
    String code,
    String approve,
  ) async {
    final msg = jsonEncode({
      'code': code,
      'approve': approve,
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
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['application'];
      return result.map((e) => ApplicationDetail.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> getRecuiterApplication(
    String companyId,
    String jobId,
    String approve,
    String sentTime,
  ) async {
    final msg = jsonEncode({
      'companyId': companyId,
      'jobId': jobId,
      'approve': approve,
      'sent_time': sentTime,
    });

    log(msg);

    Response response = await post(
      Uri.parse(BASE_URL + "application/recuiter_application.php"),
      body: msg,
    );

    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['application'];
      return result.map((e) => ApplicationDetail.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> getAllJobTitle() async {
    List<String> list = [];
    Response response = await get(Uri.parse(BASE_URL + "/job/allJobTitle.php"));
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
      final result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['data']['title'];
      list = List<String>.from(result);
    }
    return list;
  }

  Future<dynamic> createJobTitle(
    String title,
  ) async {
    final msg = jsonEncode({
      'title': title,
    });

    Response response =
        await post(Uri.parse(BASE_URL + "job/create_job_title.php"), body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> getJobRecommendSetting(String uid) async {
    final msg = jsonEncode({
      'uid': uid,
    });

    Response response = await post(
      Uri.parse(BASE_URL + "profile/profile_recommend_setting.php"),
      body: msg,
    );
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
      final result = JobRecommendSetting.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes))['data']['setting']);
      log('message setting: ${jsonDecode(utf8.decode(response.bodyBytes))['data']['setting']}');
      return result;
    } else {
      return null;
    }
  }

  Future<dynamic> createJobRecommendSetting(
    String uid,

    String job,

    int yearExperience,
    String workProvince,
    int minSalary,
    int maxSalary,
  ) async {
    final msg = jsonEncode({
      'uid': uid,
      'gender': '',
      'job': job,
      'educationId': '',
      'yearExperience': yearExperience,
      'workProvince': workProvince,
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'currency': '',
    });

  //  log('message setting:\n uid: $uid\n gender: $gender\n job: $job\n educationId: $educationId\n yearExperience: $yearExperience\n workProvince: workProvince\n minSalary: $minSalary\n maxSalary: $maxSalary\n currency: $currency');

    Response response = await post(
        Uri.parse(BASE_URL + "profile/create_profile_recommend_setting.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> updateJobRecommendSetting(
    String uid,
    String job,

    int yearExperience,
    String workProvince,
    int minSalary,
    int maxSalary,
  ) async {
    final msg = jsonEncode({
      'uid': uid,
      'gender': '',
      'job': job,
      'educationId': '',
      'yearExperience': yearExperience,
      'workProvince': workProvince,
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'currency': '',
    });

 //   log('message setting:\n uid: $uid\n job: $job\n educationId: $educationId\n yearExperience: $yearExperience\n workProvince: workProvince\n minSalary: $minSalary\n maxSalary: $maxSalary');

    Response response = await post(
        Uri.parse(BASE_URL + "profile/update_profile_recommend_setting.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  // Follow Company
  Future<dynamic> addFollowCompany(
    String companyId,
    String userId,
  ) async {
    final msg = jsonEncode({
      'companyId': companyId,
      'userId': userId,
    });

    Response response =
        await post(Uri.parse(BASE_URL + "profile/add_follower.php"), body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> removeFollowCompany(
    String companyId,
    String userId,
  ) async {
    final msg = jsonEncode({
      'companyId': companyId,
      'userId': userId,
    });

    Response response = await post(
        Uri.parse(BASE_URL + "profile/remove_follower.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> getListFollow(String userId) async {
    final msg = jsonEncode({
      'userId': userId,
    });
    Response response = await post(
        Uri.parse(BASE_URL + "profile/your_follower.php"),
        body: msg);

    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['follower'];
      return result.map((e) => FollowDetail.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> sendOTPtoMail(
    String mail,
    String typeCode,
  ) async {
    final msg = jsonEncode({
      'email': mail,
      'type_code': typeCode,
    });

    Response response =
        await post(Uri.parse(BASE_URL + "/code/api_verifycode.php"), body: msg);
    log('Show OTP to Mail: ${jsonDecode(response.body)}');
    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> checkOTP(
    String otp,
    String mail,
    String typeCode,
  ) async {
    final msg = jsonEncode({
      'email': mail,
      'otp_code': otp,
      'type_code': typeCode,
    });

    log(msg);

    Response response = await post(
        Uri.parse(BASE_URL + "/code/api_confirmcode.php"),
        body: msg);
    log('Show OTP check: ${jsonDecode(response.body)}');
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

    Response response =
        await post(Uri.parse(BASE_URL + "/update_password.php"), body: msg);
    log('${jsonDecode(response.body)}a');
    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> getJobsRecommend(String uid) async {
    final msg = jsonEncode({
      'uid': uid,
    });

    Response response = await post(
        Uri.parse(BASE_URL + "job/job_recommend_for_user.php"),
        body: msg);
    log('ket qua get list recommend: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['job'];
      if (result.isNotEmpty) {
        return result.map((e) => JobDetail.fromJson(e)).toList();
      }
    }

    return [];
  }

  Future<dynamic> getListJobActive() async {
    Response response = await get(Uri.parse(BASE_URL + "job/allJobActive.php"));
    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['job'];
      return result.map((e) => JobDetail.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> removeCV(
    String code,
  ) async {
    final msg = jsonEncode({
      'code': code,
    });

    Response response =
        await post(Uri.parse(BASE_URL + "cv/remove_cv.php"), body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> getListUserProfile() async {
    Response response =
        await get(Uri.parse(BASE_URL + "profile/getall_profile.php"));
    log('ket qua getProfile: ${response.statusCode}');
    log('ket qua getProfile: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['profile'];
      return result.map((e) => UserProfileDetail.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> updateInterviewTimeApplication(
    String code,
    String interviewTime,
  ) async {
    final msg = jsonEncode({
      'code': code,
      'interview_time': interviewTime,
    });

    Response response = await post(
        Uri.parse(BASE_URL + "/application/update_interview_application.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> getSearchJobList(
    String searchWord,
    String minSalary,
    String maxSalary,
    String typeJob,
    String yearExperience,
    String province,
  ) async {
    final msg = jsonEncode({
      'search_word': searchWord,
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'type_job': typeJob,
      'year_experience': yearExperience,
      'province': province,
    });

    log(msg);
    print(msg);

    Response response = await post(
      Uri.parse(BASE_URL + "job/job_search.php"),
      body: msg,
    );

    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      return [];
    }
  }

  Future<dynamic> addHistoryPayment(
    String money,
    String date,
    String status,
    String payment_type,
    String userId,
    String role,
  ) async {
    final msg = jsonEncode({
      'money': money,
      'date': date,
      'status': status,
      'payment_type': payment_type,
      'userId': userId,
    });

    String txtRole = '';

    if (role == 'candidate') {
      txtRole = 'profile';
    }

    if (role == 'recruiter') {
      txtRole = 'company';
    }

    Response response = await post(
        Uri.parse("${BASE_URL}payment/create_payment_$txtRole.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> getListHistoryPayments(String userId) async {
    final msg = jsonEncode({
      'uid': userId,
    });
    Response response = await post(
        Uri.parse(BASE_URL + "payment/your_payments.php"),
        body: msg);

    log('ket qua get: ${response.statusCode}');
    log('ket qua get: ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == APIStatusCode.STATUS_CODE_OK) {
      final List result =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['payment'];
      return result.map((e) => PaymentDetail.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> clickViewPlus(
    String code,
  ) async {
    final msg = jsonEncode({
      'code': code,
    });

    Response response =
        await post(Uri.parse("${BASE_URL}job/view_click.php"), body: msg);
    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> creatReport(
    String report_sender_id,
    String reported_persons_id,
    String title,
    String description,
  ) async {
    final msg = jsonEncode({
      'report_sender_id': report_sender_id,
      'reported_persons_id': reported_persons_id,
      'title': title,
      'description': description,
    });

    Response response =
        await post(Uri.parse("${BASE_URL}report/create_report.php"), body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> checkCount(
    String userId,
    String title,
  ) async {
    final msg = jsonEncode({
      'user_id': userId,
      'title': title,
    });

    Response response =
        await post(Uri.parse("${BASE_URL}count/check_count.php"), body: msg);

    return jsonDecode(response.body);
  }

  Future<dynamic> addCount(
    String userId,
    String title,
  ) async {
    final msg = jsonEncode({
      'user_id': userId,
      'title': title,
    });

    Response response =
        await post(Uri.parse("${BASE_URL}count/add_count.php"), body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> addMessage(
    String userId,
    String companyId,
    String content,
    String send,
  ) async {
    final msg = jsonEncode({
      'userId': userId,
      'companyId': companyId,
      'content': content,
      'send': send,
    });

    Response response =
        await post(Uri.parse("${BASE_URL}message/add_message.php"), body: msg);

    return jsonDecode(response.body)['success'];
  }

  Future<dynamic> addConverstation(
    String id,
    String userId,
    String companyId,
    String content,
  ) async {
    final msg = jsonEncode({
      'id': id,
      'userId': userId,
      'companyId': companyId,
      'content': content,
    });

    Response response = await post(
        Uri.parse("${BASE_URL}message/add_conversation.php"),
        body: msg);

    return jsonDecode(response.body)['success'];
  }
}
