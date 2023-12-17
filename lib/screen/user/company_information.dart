import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_controller.dart';
import 'package:jobhunt_ftl/blocs/app_event.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../component/card.dart';
import '../../value/style.dart';
import '../job/job_view_screen.dart';

class CompanyInformation extends ConsumerWidget {
  CompanyInformation({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final companyInfor = ref.watch(companyProfileProvider);
    final role = ref.watch(userLoginProvider)?.role;
    final company = ref.watch(companyInforProvider);
    final bmCheck = ref.watch(turnFollowOn);

    double screenWidth = MediaQuery.of(context).size.width;
    // bool isFollow = ref.watch(isCheckFollowCompany);

    ref.listen<InsideEvent>(
      LoginControllerProvider,
      (previous, state) {
        log('pre - state : $previous - $state');
        if (state is CreateThingErrorEvent || state is UpdateThingErrorEvent) {
          Loader.hide();
          log('error4');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(Keystring.UNSUCCESSFUL.tr),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }

        if (state is CreateThingSuccessEvent ||
            state is UpdateThingSuccessEvent) {
          Loader.hide();
          log('c-success');
          log('bmfollow: ${bmCheck}');
        }

        if (state is CreateThingLoadingEvent ||
            state is UpdateThingLoadingEvent) {
          Loader.show(context);
        }
      },
    );

    return Container(
        decoration: BoxDecoration(
            gradient: Theme.of(context).colorScheme.background == Colors.white
                ? bgGradientColor0
                : bgGradientColor1),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, isInnerBoxScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: appPrimaryColor,
                    expandedHeight: 500,
                    floating: false,
                    pinned: true,
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle, // Để tạo viền tròn
                          color: Colors.white, // Màu nền trắng
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      title: Visibility(
                        visible: isInnerBoxScrolled,
                        child: const Text(''),
                      ),
                      background: SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        width: screenWidth,
                                        height: 300,
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  gradient: Theme.of(context)
                                                              .colorScheme
                                                              .background ==
                                                          Colors.white
                                                      ? bgGradientColor0
                                                      : bgGradientColor1),
                                              child: SizedBox(
                                                  height: 300,
                                                  width: screenWidth,
                                                  child: const Image(
                                                    image: AssetImage(
                                                        'assets/image/background_company.jpg'),
                                                  )),
                                            ),
                                            Positioned(
                                              left: 2 * screenWidth / 5,
                                              right: 2 * screenWidth / 5,
                                              bottom: 0,
                                              child: SizedBox(
                                                height: 80,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  child: Container(
                                                    color: appPrimaryColor,
                                                    child: company.avatarUrl !=
                                                            ''
                                                        ? Image.network(
                                                            company.avatarUrl ??
                                                                '',
                                                            fit: BoxFit.cover)
                                                        : const Icon(
                                                            Icons.apartment,
                                                            size: 96,
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: screenWidth,
                                      child: Center(
                                          child: Text(
                                        textAlign: TextAlign.center,
                                        company.fullname.toString(),
                                        style: textTitleTab1Company,
                                      )))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.language,
                                          size: 18, // Kích thước của biểu tượng
                                          color: Colors
                                              .black, // Màu sắc của biểu tượng
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(company.web.toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          size: 18, // Kích thước của biểu tượng
                                          color: Colors
                                              .black, // Màu sắc của biểu tượng
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(company.phone.toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.email,
                                          size: 18, // Kích thước của biểu tượng
                                          color: Colors
                                              .black, // Màu sắc của biểu tượng
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(company.email.toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  role != null
                                      ? role != 'recruiter'
                                          ? SizedBox(
                                              width: screenWidth,
                                              height: 55,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (bmCheck) {
                                                      showUnfollowDialog(
                                                          context, ref);
                                                    } else {
                                                      ref
                                                          .read(
                                                              LoginControllerProvider
                                                                  .notifier)
                                                          .addFollowCompany(
                                                            company?.uid ?? '0',
                                                            ref
                                                                    .watch(
                                                                        userLoginProvider)
                                                                    ?.uid ??
                                                                '0',
                                                          );
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: bmCheck
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .white),
                                                          color: bmCheck
                                                              ? Colors.white
                                                              : appPrimaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0)),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              bmCheck
                                                                  ? Icons.check
                                                                  : Icons.add,
                                                              color: bmCheck
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .white,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              bmCheck
                                                                  ? '${Keystring.FOllOWING.tr}'
                                                                  : '${Keystring.COMPANY_FOllOW.tr}',
                                                              style: TextStyle(
                                                                  color: bmCheck
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white),
                                                            )
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox(height: 0)
                                      : SizedBox(
                                          width: 0,
                                        )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: SliverTabBarDelegate(
                      TabBar(
                        indicatorColor: appPrimaryColor,
                        unselectedLabelColor: Colors.grey,
                        labelColor: appPrimaryColor,
                        tabs: [
                          Tab(
                            child: Text(Keystring.INFORMATION.tr),
                          ),
                          Tab(
                            child: Text(
                              '${Keystring.NEWS_RECRUITMENT.tr} ',
                            ),
                          ),
                        ],
                        onTap: (index) {},
                      ),
                    ),
                    floating: false,
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  Tab1(company: company),
                  const Tab2(),
                ],
              ),
            ),
          ),
        ));
  }

  void showUnfollowDialog(BuildContext context, WidgetRef ref) {
    final company = ref.watch(companyInforProvider);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // bool isFollow = ref.watch(isCheckFollowCompany);
        final follow = ref.watch(followingProvider);
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Điều chỉnh độ cong của các góc
          ),
          content: Text(
            '${Keystring.CONTENT_DIALOG_UNFOLLOW.tr}',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                      height: 40,
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xFFE4E4E4),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            '${Keystring.CANCEL.tr}',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      ref
                          .read(LoginControllerProvider.notifier)
                          .removeFollowCompany(
                            company?.uid ?? '0',
                            ref.watch(userLoginProvider)?.uid ?? '0',
                          );
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                      height: 40,
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: appPrimaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            '${Keystring.UNFOLLOW.tr}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null && value) {
        print('User unfollowed');
      } else {
        print('User canceled unfollow');
      }
    });
  }
}

class Tab1 extends ConsumerWidget {
  Tab1({required this.company, Key? key}) : super(key: key);
  CompanyDetail company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isExpanded = ref.watch(isExpandedCompanySeenInforProvider);
    log(company.toString());

    final address = company.address!;
    final last = address.lastIndexOf(',');
    String addressRoad = address.substring(
        0, address.lastIndexOf(',', address.lastIndexOf(',', last - 1) - 1));
    String addressWard = getWardName(
        address.substring(
            address.lastIndexOf(',', address.lastIndexOf(',', last - 1) - 1) +
                1,
            address.lastIndexOf(',', last - 1)),
        ref);
    String addressDistrict = getDistrictName(
        address.substring(
            address.lastIndexOf(',', last - 1) + 1, address.lastIndexOf(',')),
        ref);
    String addressProvince = getProvinceName(address.substring(last + 1), ref);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
            width: screenWidth,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: SizedBox(
                  child: Text(
                    Keystring.INTRODUCTION.tr,
                    style: textTitleTab1Company,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
            width: screenWidth,
          ),
          Row(
            children: [
              SizedBox(
                width: screenWidth,
                child: Container(
                  width: 9 * screenWidth / 10,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        company.description ?? '',
                        style: textNormal,
                        overflow: isExpanded ? null : TextOverflow.ellipsis,
                        maxLines: isExpanded ? null : 8,
                      ),
                      GestureDetector(
                          onTap: () {
                            ref
                                .read(
                                    isExpandedCompanySeenInforProvider.notifier)
                                .state = !isExpanded;
                          },
                          child: Text(
                            isExpanded
                                ? Keystring.COLLAPSE.tr
                                : Keystring.SEE_MORE.tr,
                            style: TextStyle(
                              color: appPrimaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
            width: screenWidth,
          ),
          SizedBox(
            height: 10,
            width: screenWidth,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: Text(Keystring.ADDRESS.tr, style: textTitleTab1Company),
              )
            ],
          ),
          SizedBox(
            height: 10,
            width: screenWidth,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Text(
                      '$addressRoad, $addressWard, $addressDistrict, $addressProvince',
                      style: textNormal),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Tab2 extends ConsumerWidget {
  const Tab2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(JobInCompanyProvider);
    return data.isNotEmpty
        ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              String avatar = data[index].company?.avatarUrl ?? '';
              String name = data[index].name ?? '';
              String companyName = data[index].company?.fullname ?? '';
              String province = getProvinceName(
                  data[index]
                      .address!
                      .substring(data[index].address!.lastIndexOf(',') + 1),
                  ref);
              String money = data[index].maxSalary != -1
                  ? '${data[index].maxSalary} ${data[index].currency}'
                  : Keystring.ARGEEMENT.tr;
              String deadline = data[index].deadline ?? '';

              return GestureDetector(
                onTap: () {
                  ref.read(jobDetailProvider.notifier).state = data[index];
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JobViewScreen()),
                  );
                },
                child: AppJobCard(
                  avatar: avatar,
                  name: name,
                  companyName: companyName,
                  province: province,
                  money: money,
                  deadline: deadline,
                ),
              );
            },
            itemCount: data.length,
          )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 80),
            child: Center(
              child: Text(
                Keystring.NO_DATA.tr,
                style: textNormal,
              ),
            ),
          );
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  SliverTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
