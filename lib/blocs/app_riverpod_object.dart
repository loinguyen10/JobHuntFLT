import 'dart:developer';
import 'package:jobhunt_ftl/model/address.dart';
import 'package:jobhunt_ftl/model/application.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/model/cv.dart';
import 'package:jobhunt_ftl/model/favorite.dart';
import 'package:jobhunt_ftl/model/follow.dart';
import 'package:jobhunt_ftl/model/job.dart';
import 'package:jobhunt_ftl/model/payment.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
import 'package:jobhunt_ftl/repository/repository.dart';
import 'package:riverpod/riverpod.dart';

import '../model/job_setting.dart';
import '../model/user.dart';
import 'app_riverpod_void.dart';

// final emailLoginProvider = StateProvider((ref) => '');
// final passwordLoginProvider = StateProvider((ref) => '');
final userLoginProvider = StateProvider<UserDetail?>((ref) => null);
final userProfileProvider = StateProvider<UserProfileDetail?>((ref) => null);

final checkboxRememberProvider = StateProvider.autoDispose((ref) => false);

final companyProfileProvider = StateProvider<CompanyDetail?>((ref) => null);

final jobDetailProvider = StateProvider<JobDetail?>((ref) => null);

final checkboxTermProvider = StateProvider.autoDispose((ref) => false);

final authRepositoryProvider = Provider<InsideService>((ref) {
  return InsideService();
});

final listCVCompanyProvider =
    FutureProvider<List<CompanyInfo>>((ref) => getCVList());

final listJobProvider = FutureProvider<List<JobDetail>>((ref) => getJobList());

final listActiveJobProvider =
    FutureProvider<List<JobDetail>>((ref) => getActiveJobList());

final listRecommendJobProvider = FutureProvider<List<JobDetail>>(
  (ref) => getRecommendJobList(ref.watch(userLoginProvider)?.uid ?? '0'),
);

final listPostJobProvider = FutureProvider<List<JobDetail>>(
    (ref) => getPostedJobList(ref.watch(companyProfileProvider)?.uid ?? '0'));

final listSuggestionJobProvider = FutureProvider<List<JobDetail>>((ref) =>
    getSuggestionJobList(ref.watch(jobDetailProvider)?.companyId ?? '0'));

final listCompanyProvider =
    FutureProvider<List<CompanyDetail>>((ref) => getCompanyList());

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

final fullNameProfileProvider =
    StateProvider((ref) => ref.watch(userProfileProvider)?.fullName ?? "");

final emailProfileProvider = StateProvider((ref) =>
    ref.watch(userProfileProvider)?.email ??
    ref.watch(userLoginProvider)?.email ??
    '');

final phoneProfileProvider =
    StateProvider((ref) => ref.watch(userProfileProvider)?.phone ?? "");

final dateBirthProvider = StateProvider.autoDispose(
    (ref) => ref.watch(userProfileProvider)?.birthday ?? "");

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

final premiumExpireProfileProvider =
    StateProvider((ref) => ref.watch(userProfileProvider)?.premiumExpiry ?? "");

//company
final avatarCompanyProvider =
    StateProvider((ref) => ref.watch(companyProfileProvider)?.avatarUrl ?? "");

final fullNameCompanyProvider =
    StateProvider((ref) => ref.watch(companyProfileProvider)?.fullname ?? "");

final emailCompanyProvider = StateProvider((ref) =>
    ref.watch(companyProfileProvider)?.email ??
    ref.watch(userLoginProvider)?.email ??
    '');

final websiteCompanyProvider =
    StateProvider((ref) => ref.watch(companyProfileProvider)?.web ?? "");

final taxCodeCompanyProvider =
    StateProvider((ref) => ref.watch(companyProfileProvider)?.taxcode ?? "");

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
      final last = address!.lastIndexOf(',');
      if (address.substring(
              address.lastIndexOf(',', address.lastIndexOf(',', last - 1) - 1) +
                  1,
              address.lastIndexOf(',', last - 1)) ==
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

final premiumExpireCompanyProvider = StateProvider(
    (ref) => ref.watch(companyProfileProvider)?.premiumExpiry ?? "");

//job

final jobNameProvider =
    StateProvider((ref) => ref.watch(jobDetailProvider)?.name ?? "");

final jobSalaryProvider = StateProvider.autoDispose((ref) {
  if (ref.watch(jobDetailProvider) != null) {
    if (ref.watch(jobDetailProvider)!.minSalary! < 0 &&
        ref.watch(jobDetailProvider)!.maxSalary! < 0) {
      return false;
    }
  }

  return true;
});

final jobMinSalaryProvider =
    StateProvider<int>((ref) => ref.watch(jobDetailProvider)?.minSalary ?? 0);

final jobMaxSalaryProvider =
    StateProvider<int>((ref) => ref.watch(jobDetailProvider)?.maxSalary ?? 0);

final jobCurrencyProvider = StateProvider.autoDispose<CurrencyList?>((ref) {
  if (ref.watch(jobDetailProvider) != null &&
      !ref.watch(listCurrencyProvider).isLoading) {
    var list = ref.watch(listCurrencyProvider).value;
    var currency = ref.watch(jobDetailProvider)?.currency;

    for (var x in list!) {
      if (currency == x.code) {
        return x;
      }
    }
  }
  return CurrencyList();
});

final jobYearExperienceProvider = StateProvider<int>(
    (ref) => ref.watch(jobDetailProvider)?.yearExperience ?? 0);

final jobTypeChooseProvider =
    StateProvider.autoDispose((ref) => ref.watch(jobDetailProvider)?.typeJob);

final jobNumberCandidateProvider = StateProvider<int>(
    (ref) => ref.watch(jobDetailProvider)?.numberCandidate ?? 0);

final provinceJobProvider = StateProvider.autoDispose<ProvinceList?>((ref) {
  if (!ref.watch(listProvinceProvider).isLoading) {
    var list = ref.watch(listProvinceProvider).value;
    for (var x in list!) {
      if (ref.watch(jobDetailProvider) != null) {
        var address = ref.watch(jobDetailProvider)?.address;
        if (address?.substring(address.lastIndexOf(',') + 1) == x.code) {
          return x;
        }
      } else if (ref.watch(companyProfileProvider)?.uid != null) {
        var address = ref.watch(companyProfileProvider)?.address;
        if (address?.substring(address.lastIndexOf(',') + 1) == x.code) {
          return x;
        }
      }
    }
  }
  return ProvinceList();
});

final districtJobProvider = StateProvider.autoDispose<DistrictList?>((ref) {
  if (!ref.watch(listDistrictProvider).isLoading) {
    var list = ref.watch(listDistrictProvider).value;
    for (var x in list!) {
      if (ref.watch(jobDetailProvider) != null) {
        var address = ref.watch(jobDetailProvider)?.address;
        if (address?.substring(0, address.indexOf(',')) == x.code) {
          return x;
        }
      } else if (ref.watch(companyProfileProvider)?.uid != null) {
        var address = ref.watch(companyProfileProvider)?.address;
        if (address?.substring(
                address.lastIndexOf(',', address.lastIndexOf(',') - 1) + 1,
                address.lastIndexOf(',')) ==
            x.code) {
          return x;
        }
      }
    }
  }
  return DistrictList();
});

final jobDescriptionProvider =
    StateProvider((ref) => ref.watch(jobDetailProvider)?.description ?? "");

final jobCandidateRequirementProvider = StateProvider(
    (ref) => ref.watch(jobDetailProvider)?.candidateRequirement ?? "");

final jobBenefitProvider =
    StateProvider((ref) => ref.watch(jobDetailProvider)?.jobBenefit ?? "");

final listJobTagProviderProvider = StateProvider<List<String>>((ref) {
  if (ref.watch(jobDetailProvider) != null) {
    var job = ref.watch(jobDetailProvider)?.tag?.split(',');
    return [...job!];
  }
  return [];
});

final jobDeadlineProvider = StateProvider.autoDispose(
    (ref) => ref.watch(jobDetailProvider)?.deadline ?? "");

final jobActiveProvider = StateProvider.autoDispose(
    (ref) => ref.watch(jobDetailProvider)?.active ?? 0);

//cv & application
final cvUploadProvider = StateProvider((ref) => "");

final uploadCheckProvider = StateProvider((ref) => "waiting");

final cvDetailProvider = StateProvider<CVDetail?>((ref) => CVDetail());

final listAllCVProvider =
    FutureProvider<List<CVDetail>>((ref) => getAllCVList());

final listYourCVProvider = FutureProvider<List<CVDetail>>(
    (ref) => getYourCVList(ref.watch(userLoginProvider)!.uid ?? '0'));

final lastNumberCVProvider = StateProvider<int>((ref) {
  final list = ref.watch(listYourCVProvider);
  if (!list.isLoading && list.value!.isNotEmpty) {
    return int.parse(list.value!.last.code ?? '0');
  }

  return 0;
});

final listYourFavoriteProvider = FutureProvider<List<FavoriteDetail>>(
    (ref) => getYourFavoriteList(ref.watch(userLoginProvider)!.uid ?? '0'));

final turnBookmarkOn = StateProvider<bool>((ref) {
  final list = ref.watch(listYourFavoriteProvider);
  final job = ref.watch(jobDetailProvider);

  List<FavoriteDetail> listF = [];

  list.maybeWhen(
    data: (data) {
      listF = data;
    },
    orElse: () {
      listF = [];
    },
  );

  log('listF: ${listF.length}');

  for (var i in listF) {
    if (job!.code == i.jobId) {
      log('message111: ${job.code} & ${i.jobId} ');
      return true;
    }
  }

  return false;
});

final CVChooseProvider =
    StateProvider.autoDispose<CVDetail?>((ref) => CVDetail());

final listCandidateApplicationProvider =
    FutureProvider<List<ApplicationDetail>>((ref) =>
        getCandidateApplication(ref.watch(userLoginProvider)!.uid ?? '0'));

final listCandidateApproveApplicationProvider =
    FutureProvider<List<ApplicationDetail>>((ref) {
  final listAll = ref.watch(listCandidateApplicationProvider);
  List<ApplicationDetail> list = [];

  listAll.maybeWhen(
    data: (data) {
      for (var i in data) {
        if (i.approve == '1') list.add(i);
      }
    },
    orElse: () {
      list = [];
    },
  );

  return list;
});

final listCandidateRejectApplicationProvider =
    FutureProvider<List<ApplicationDetail>>((ref) {
  final listAll = ref.watch(listCandidateApplicationProvider);
  List<ApplicationDetail> list = [];

  listAll.maybeWhen(
    data: (data) {
      for (var i in data) {
        if (i.approve == '0') list.add(i);
      }
    },
    orElse: () {
      list = [];
    },
  );

  return list;
});

final listCandidateWaitingApplicationProvider =
    FutureProvider<List<ApplicationDetail>>((ref) {
  final listAll = ref.watch(listCandidateApplicationProvider);
  List<ApplicationDetail> list = [];

  listAll.maybeWhen(
    data: (data) {
      for (var i in data) {
        if (i.approve == null || i.approve == '') list.add(i);
      }
    },
    orElse: () {
      list = [];
    },
  );

  return list;
});

final StatusCheckProvider = StateProvider((ref) => '');

final getListRecuiterApplicationProvider =
    FutureProvider<List<ApplicationDetail>>((ref) => getRecuiterApplication(
        ref.watch(userLoginProvider)!.uid ?? '0', '', '', ''));

final listRecuiterApplicationProvider = StateProvider<List<ApplicationDetail>>(
  (ref) {
    final listAll = ref.watch(getListRecuiterApplicationProvider);
    List<ApplicationDetail> list = [];

    listAll.maybeWhen(
      data: (data) {
        list.addAll(data);
      },
      orElse: () {
        list = [];
      },
    );

    log('list recuiter after: ${list.length}');
    return list;
  },
);

final listRecuiterMonthApplicationProvider =
    FutureProvider<List<ApplicationDetail>>((ref) {
  final listAll = ref.watch(getListRecuiterApplicationProvider);
  List<ApplicationDetail> list = [];

  listAll.maybeWhen(
    data: (data) {
      for (var i in data) {
        if (i.sendTime!.substring(3, 5) == DateTime.now().month.toString()) {
          log('this month: ${i.sendTime!.substring(3, 5)} & ${DateTime.now().month}');
          list.add(i);
        }
      }
    },
    orElse: () {
      list = [];
    },
  );

  list.sort((b, a) => a.sendTime!.compareTo(b.sendTime!));
  return list;
});

final CandidateProfileProvider =
    StateProvider<UserProfileDetail?>((ref) => UserProfileDetail());

final applicationDetailProvider =
    StateProvider<ApplicationDetail?>((ref) => ApplicationDetail());

// recommend job
final userDetailJobSettingProvider =
    StateProvider<JobRecommendSetting?>((ref) => null);

// final genderJobSettingProvider = StateProvider(
//     (ref) => ref.watch(userDetailJobSettingProvider)?.gender ?? '');

final listJob2SettingProvider = StateProvider<List<String>>((ref) {
  if (ref.watch(userDetailJobSettingProvider) != null) {
    var job = ref.watch(userDetailJobSettingProvider)?.job?.split(',');
    return [...job!];
  }
  return [];
});

final listAllTitleJobSettingProvider =
    FutureProvider<List<String>>((ref) => getAllJobTitle());

final minSalaryJobSettingProvider = StateProvider<int>(
    (ref) => ref.watch(userDetailJobSettingProvider)?.minSalary ?? 0);

final maxSalaryJobSettingProvider = StateProvider<int>(
    (ref) => ref.watch(userDetailJobSettingProvider)?.maxSalary ?? 0);

// final currencyChooseJobSettingProvider =
//     StateProvider.autoDispose<CurrencyList?>((ref) {
//   if (ref.watch(userDetailJobSettingProvider) != null &&
//       !ref.watch(listCurrencyProvider).isLoading) {
//     var list = ref.watch(listCurrencyProvider).value;
//     var currency = ref.watch(userDetailJobSettingProvider)?.currency;
//
//     for (var x in list!) {
//       if (currency == x.code) {
//         return x;
//       }
//     }
//   }
//   return CurrencyList();
// });

final provinceChooseJobSettingProvider =
    StateProvider.autoDispose<ProvinceList?>((ref) => ProvinceList());

final listProvinceChooseJobSettingProvider =
    StateProvider<List<ProvinceList>>((ref) {
  if (!ref.watch(listProvinceProvider).isLoading) {
    List<ProvinceList> list = [];
    var listProvince = ref.watch(listProvinceProvider).value;
    var workProvinceValue =
        ref.watch(userDetailJobSettingProvider)?.workProvince;
    var provinceList = workProvinceValue?.split(',');

    log('message: $workProvinceValue and $provinceList');

    if (workProvinceValue != null && provinceList!.isNotEmpty) {
      for (var p in provinceList) {
        for (var x in listProvince!) {
          if (p == x.code) {
            list.add(x);
          }
        }
      }
      return list;
    }
  }
  return [];
});

final yearExpericementJobSettingProvider = StateProvider(
    (ref) => ref.watch(userDetailJobSettingProvider)?.yearExperience ?? 0);

final educationChooseJobSettingProvider =
    StateProvider<EducationList?>((ref) => EducationList());

final listEducationJobSettingProvider =
    FutureProvider<List<EducationList>>((ref) => getEducationList());

// final listEducationShowJobSettingProvider =
//     StateProvider<List<EducationList>>((ref) {
//   if (ref.watch(userDetailJobSettingProvider) != null) {
//     var education = ref.watch(userDetailJobSettingProvider)?.education;
//     return [...education!];
//   }
//   return [];
// });

//
// final userDetailJobSettingProvider =
//     StateProvider<JobRecommendSetting?>((ref) => JobRecommendSetting());
//company infor
final isExpandedCompanySeenInforProvider = StateProvider<bool>((ref) => false);

final companyInforProvider =
    StateProvider<CompanyDetail>((ref) => CompanyDetail());

final listCompanyJobProvider = FutureProvider<List<JobDetail>>(
    (ref) => getPostedJobList(ref.watch(companyProfileProvider)!.uid ?? '0'));

// Follow the company
final isCheckFollowCompany = StateProvider<bool>((ref) => false);

final followingProvider = StateProvider<FollowDetail?>((ref) => FollowDetail());

final listYourFollowProvider = FutureProvider<List<FollowDetail>>(
    (ref) => getYourFollowList(ref.watch(userLoginProvider)!.uid ?? '0'));

final turnFollowOn = StateProvider<bool>((ref) {
  final list = ref.watch(listYourFollowProvider);
  final company = ref.watch(companyInforProvider);

  List<FollowDetail> listFollow = [];

  list.maybeWhen(
    data: (data) {
      listFollow = data;
    },
    orElse: () {
      listFollow = [];
    },
  );

  log('listFollow: ${listFollow.length}');
  log('company: ${company.uid}');

  for (var i in listFollow) {
    if (company.uid == i.companyId) {
      log('message11111: ${company.uid} & ${i.companyId} ');
      return true;
    }
  }

  return false;
});
final listJobOfCompanyProvider = FutureProvider<List<JobDetail>>((ref) =>
    getPostedJobList(ref.watch(jobDetailProvider)!.company?.uid ?? '0'));

final emailsaveProvider = StateProvider((ref) => '');
//
final itemPayMentProvider = StateProvider<int>((ref) => 1);
final isitemPayMentProvider = StateProvider<bool>((ref) => false);

final emailRegisterProvider = StateProvider((ref) => '');
final passwordRegisterProvider = StateProvider((ref) => '');
final timerProvider = StateProvider((ref) => 10);

final listJobTagCompanyProvider = StateProvider<List<String>>((ref) {
  if (ref.watch(companyProfileProvider) != null) {
    var job = ref.watch(companyProfileProvider)?.job?.split(',');
    return [...job!];
  }
  return [];
});

final listActivePostJobCompanyProvider = FutureProvider<List<JobDetail>>((ref) {
  final listAll = ref.watch(listPostJobProvider);
  List<JobDetail> list = [];

  listAll.maybeWhen(
    data: (data) {
      for (var i in data) {
        if (i.active == 1) {
          list.add(i);
        }
      }
    },
    orElse: () {
      list = [];
    },
  );
  return list;
});
final isShowTimeProvider = StateProvider<bool>((ref) => false);

final dateSearchProvider = StateProvider.autoDispose((ref) => '');

final timeInterviewApplicationProvider = StateProvider.autoDispose(
    (ref) => ref.watch(applicationDetailProvider)?.interviewTime ?? '');

final timeTimeInterviewApplicationProvider = StateProvider.autoDispose((ref) =>
    ref.watch(applicationDetailProvider)?.interviewTime != null
        ? ref.watch(timeInterviewApplicationProvider).substring(
            ref.watch(timeInterviewApplicationProvider).indexOf(' ') + 1)
        : '');

final dateTimeInterviewApplicationProvider = StateProvider.autoDispose((ref) =>
    ref.watch(applicationDetailProvider)?.interviewTime != null
        ? ref.watch(timeInterviewApplicationProvider).substring(
            0, ref.watch(timeInterviewApplicationProvider).indexOf(' '))
        : '');

final listJobSearchProvider = StateProvider<List<JobDetail>>((ref) => []);

final numberJobSearchProvider = StateProvider<int>((ref) => 0);

// final todayJobSearchProvider = StateProvider((ref) => '');
final listUserProfilevider =
    FutureProvider<List<UserProfileDetail>>((ref) => getUserProfileList());
//
final listHistoryPaymentsProvider = FutureProvider<List<PaymentDetail>>((ref) =>
    getYourHistoryPaymentList(
        ref.watch(userLoginProvider)?.uid.toString() ?? '0'));

final provinceBestJobProvider = StateProvider<ProvinceList?>((ref) => null);

final districtBestJobProvider = StateProvider<DistrictList?>((ref) => null);

final listJobBestProvider = StateProvider<List<JobDetail>>(
  (ref) {
    final province = ref.watch(provinceBestJobProvider);
    final district = ref.watch(districtBestJobProvider);
    final data = ref.watch(listActiveJobProvider);

    List<JobDetail> listBest = [];
    List<JobDetail> list = [];

    data.maybeWhen(
      data: (data) {
        list = data;
      },
      orElse: () {
        list = [];
      },
    );

    listBest.clear();
    listBest.addAll(list);
    if (province != null) {
      listBest.clear();
      for (var job in list) {
        final address = job.address;
        if (district == null) {
          if (address?.substring(address.lastIndexOf(',') + 1) ==
              province.code) {
            listBest.add(job);
          }
        } else {
          if (address == '${district.code},${province.code}') {
            listBest.add(job);
          }
        }
      }
    }

    listBest.sort((b, a) => a.numberClick!.compareTo(b.numberClick!));
    log('length: ${listBest.length}');
    return listBest;
  },
);
final ReportingReasonProvider = StateProvider<String>((ref) => '');
final OtherReportingReasonProvider = StateProvider<String>((ref) => '');
final OtherReasonProvider = StateProvider<bool>((ref) => false);
final checkCreateReportProvider = StateProvider<bool>((ref) => false);
final candidateRecommendProvider =
    StateProvider<JobRecommendSetting?>((ref) => JobRecommendSetting());

final JobInCompanyProvider = StateProvider(
  (ref) {
    final companyuid = ref.watch(companyInforProvider).uid;

    final dataJobActive = ref.watch(listActiveJobProvider);
    List<JobDetail> listJobActive = [];
    List<JobDetail> listJob = [];

    dataJobActive.maybeWhen(
      data: (data) {
        listJobActive.addAll(data);
      },
      orElse: () {
        listJobActive = [];
      },
    );

    for (var job in listJobActive) {
      if (job.companyId == companyuid) {
        listJob.add(job);
      }
    }

    return listJob;
  },
);
