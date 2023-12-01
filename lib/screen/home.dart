import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/card.dart';
import 'package:jobhunt_ftl/component/custom_page_route.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/screen/job/recuiter_application_screen.dart';
import 'package:jobhunt_ftl/screen/user/company_screen.dart';
import 'package:jobhunt_ftl/screen/job/edit_job.dart';
import 'package:jobhunt_ftl/screen/job/job_screen.dart';
import 'package:jobhunt_ftl/screen/menu_screen.dart';
import 'package:jobhunt_ftl/screen/user/searchScreen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import '../model/userprofile.dart';
import '../value/style.dart';
import 'job/viewall_screen.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userLoginProvider);
    final profile = ref.watch(userProfileProvider);
    final company = ref.watch(companyProfileProvider);

    if (company != null) {
      ref.watch(listRecuiterMonthApplicationProvider);
      ref.watch(listActivePostJobCompanyProvider);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimaryColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Center(
              child: Row(
                children: [
                  Text(
                    "${Keystring.HELLO.tr}: ",
                    style: textCV,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: profile?.level == 'Premium'
                            ? Colors.yellow
                            : Colors.transparent,
                        width: 4.0,
                      ),
                    ),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(24), // Image radius
                        child: profile != null || company != null
                            ? profile?.avatarUrl != null &&
                                    profile?.avatarUrl != ''
                                ? Image.network(
                                    profile?.avatarUrl ?? '',
                                    fit: BoxFit.cover,
                                  )
                                : company?.avatarUrl != null &&
                                        company?.avatarUrl != ''
                                    ? Image.network(
                                        company?.avatarUrl ?? '',
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(
                                        Icons.no_accounts_outlined,
                                        size: 48,
                                      )
                            : Icon(
                                Icons.no_accounts_outlined,
                                size: 48,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => MenuScreen()),
            Navigator.push(
              context,
              SlidePageRoute(child: MenuScreen()),
            );
          },
          icon: Icon(Icons.menu),
        ),
      ),
      body: ScreenHome(
        company: company,
        profile: profile,
      ),
    );
    // );
  }
}

class ScreenHome extends ConsumerStatefulWidget {
  const ScreenHome({super.key, this.company, this.profile});
  final CompanyDetail? company;
  final UserProfileDetail? profile;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScreenHome();
}

class _ScreenHome extends ConsumerState<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: widget.company == null
              ? Column(
                  //member & guest screen
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.black, width: 1),
                        ),
                        elevation: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Icon(
                                Icons.search,
                                size: 30,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                Keystring.SEARCH,
                                style: textNormalHint,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    widget.profile != null
                        ? Container(
                            margin: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      Keystring.RECOMMEND_JOB.tr,
                                      style: textJobHome,
                                    ),
                                    GestureDetector(
                                      onTap: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  JobRecommendUser()),
                                        )
                                      },
                                      child: Text(
                                        '${Keystring.VIEW_ALL.tr} ➤    ',
                                        style: textNormalBold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Card(
                                  shape:
                                      Border.all(color: Colors.white, width: 2),
                                  elevation: 5,
                                  child: Container(
                                    height: 224,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: const JobRecommendListScreen(
                                        homeMode: true),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(height: 0),
                    //
                    SizedBox(
                      height: widget.profile != null ? 24 : 0,
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Keystring.BEST_JOB.tr,
                                style: textJobHome,
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            JobBestAllScreen()),
                                  )
                                },
                                child: Text(
                                  '${Keystring.VIEW_ALL.tr} ➤    ',
                                  style: textNormalBold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Card(
                            shape: Border.all(color: Colors.white, width: 2),
                            // margin: EdgeInsets.all(8),
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: const JobBestListScreen(itemCount: 3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Keystring.VERIFIED_COMPANIES.tr,
                                style: textJobHome,
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CompanyVerifyScreen()),
                                  )
                                },
                                child: Text(
                                  '${Keystring.VIEW_ALL.tr} ➤    ',
                                  style: textNormalBold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Card(
                            shape: Border.all(color: Colors.white, width: 2),
                            // margin: EdgeInsets.all(8),
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: const CompanyPremiumScreen(itemCount: 3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //
                    SizedBox(
                      height: 24,
                    ),
                  ],
                )
              : Column(
                  //company screen
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AppSquareHomeCard(
                                icon: Icons.description_outlined,
                                title: Keystring.CV_Month.tr,
                                count: ref
                                        .watch(
                                            listRecuiterMonthApplicationProvider)
                                        .value
                                        ?.length
                                        .toString() ??
                                    '0',
                                bgColor: Colors.greenAccent,
                              ),
                              AppSquareHomeCard(
                                icon: CupertinoIcons.briefcase,
                                title: Keystring.ACTIVE_JOB.tr,
                                count: ref
                                        .watch(listActivePostJobCompanyProvider)
                                        .value
                                        ?.length
                                        .toString() ??
                                    '0',
                                bgColor: Colors.redAccent,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                Keystring.Posted_Jobs.tr,
                                style: textJobHome,
                              ),
                              InkWell(
                                onTap: () {
                                  ref.refresh(jobDetailProvider);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JobEditScreen()),
                                  );
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Card(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: JobPostedCompanyScreen(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
