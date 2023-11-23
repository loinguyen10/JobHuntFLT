import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/screen/job/recuiter_application_screen.dart';
import 'package:jobhunt_ftl/screen/user/company_screen.dart';
import 'package:jobhunt_ftl/screen/job/edit_job.dart';
import 'package:jobhunt_ftl/screen/job/job_screen.dart';
import 'package:jobhunt_ftl/screen/menu_screen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

import '../blocs/app_controller.dart';
import '../component/loader_overlay.dart';
import '../value/style.dart';
import 'job/job_recommend_user.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userLoginProvider);
    final profile = ref.watch(userProfileProvider);
    final company = ref.watch(companyProfileProvider);

    return
        // SafeArea(child:
        Scaffold(
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
                  ClipOval(
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
                ],
              ),
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuScreen()),
            );
          },
          icon: Icon(Icons.menu),
        ),
      ),
      body: ScreenHome(company: company),
    );
    // );
  }
}

class ScreenHome extends ConsumerStatefulWidget {
  const ScreenHome({super.key, this.company});
  final CompanyDetail? company;

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
                        log('click search');
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
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            shape: Border.all(color: Colors.white, width: 2),
                            // margin: EdgeInsets.all(8),
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: const JobRecommendListScreen(),
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
                                Keystring.BEST_JOB.tr,
                                style: textJobHome,
                              ),
                              Text(
                                '${Keystring.VIEW_ALL.tr} ➤    ',
                                style: textNormalBold,
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
                              decoration: BoxDecoration(color: Colors.white),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: const JobBestListScreen(),
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
                              Text(
                                '${Keystring.VIEW_ALL.tr} ➤    ',
                                style: textNormalBold,
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
                              decoration: BoxDecoration(color: Colors.white),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: const CompanyPremiumScreen(),
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              Keystring.CV_Today.tr,
                              style: textJobHome,
                            ),
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
                              child: const ApplicationTodayRecuiterScreen(),
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
