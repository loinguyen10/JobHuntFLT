import 'dart:convert';
import 'dart:developer';

import 'package:jobhunt_ftl/model/address.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/model/cv.dart';
import 'package:jobhunt_ftl/model/job.dart';
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

final jobDetailProvider = StateProvider<JobDetail?>((ref) => JobDetail());

final checkboxTermProvider = StateProvider.autoDispose((ref) => false);

final authRepositoryProvider = Provider<InsideService>((ref) {
  return InsideService();
});

final listCVCompanyProvider =
    FutureProvider<List<CompanyInfo>>((ref) => getCVList());

final listJobProvider = FutureProvider<List<JobDetail>>((ref) => getJobList());

final listRecommendJobProvider =
    FutureProvider<List<JobDetail>>((ref) => getRecommendJobList());

final listPostJobProvider = FutureProvider<List<JobDetail>>(
    (ref) => getPostedJobList(ref.watch(companyProfileProvider)!.uid ?? '0'));

final listSuggestionJobProvider = FutureProvider<List<JobDetail>>((ref) =>
    getSuggestionJobList(ref.watch(jobDetailProvider)!.companyId ?? '0'));

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

//job

final jobNameProvider =
    StateProvider((ref) => ref.watch(jobDetailProvider)?.name ?? "");

final jobSalaryProvider = StateProvider.autoDispose((ref) {
  if (ref.watch(jobDetailProvider)?.code != null) {
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
      if (ref.watch(jobDetailProvider)?.code != null) {
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
      if (ref.watch(jobDetailProvider)?.code != null) {
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

final jobTagProvider =
    StateProvider((ref) => ref.watch(jobDetailProvider)?.tag ?? "");

final jobDeadlineProvider = StateProvider.autoDispose(
    (ref) => ref.watch(jobDetailProvider)?.deadline ?? "");

final jobActiveProvider = StateProvider.autoDispose((ref) {
  if (ref.watch(jobDetailProvider)?.active == 1) {
    return true;
  }

  return false;
});

//job
final cvUploadProvider = StateProvider((ref) => "");

final uploadCheckProvider = StateProvider((ref) => "waiting");

final cvDetailProvider = StateProvider<CVDetail?>((ref) => CVDetail());

final listYourCVProvider = FutureProvider<List<CVDetail>>(
    (ref) => getYourCVList(ref.watch(userLoginProvider)!.uid ?? '0'));
