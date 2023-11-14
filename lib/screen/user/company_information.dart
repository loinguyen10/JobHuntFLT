import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../component/card.dart';
import '../../value/style.dart';
import '../job/job_view_screen.dart';

class CompanyInformation extends ConsumerWidget {
  CompanyInformation({required this.company, Key? key}) : super(key: key);
  CompanyDetail company;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final companyInfor = ref.watch(companyProfileProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    int jobOfCompany = 0;
    bool isFollow = ref.watch(isCheckFollowCompany);
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
                    backgroundColor: Colors.blue,
                    expandedHeight: 460.0,
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
                        child: const Text('Scrollable TabBar Example'),
                      ),
                      background: Container(
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
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                child: Container(
                                                  color: Colors.blue,
                                                  child: company.avatarUrl != ''
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
                                      company.fullname.toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            fontSize: 12,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            fontSize: 12,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            fontSize: 12,
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
                                  height: 55,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () => {
                                        ref
                                            .read(isCheckFollowCompany.notifier)
                                            .state = !isFollow
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1,color:isFollow ? Colors.black : Colors.white),
                                              color:isFollow? Colors.white : Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  isFollow ? Icons.check : Icons.add,
                                                  color: isFollow? Colors.black :Colors.white,
                                                ),
                                                SizedBox(width: 5,),
                                                Text(isFollow ? '${Keystring.FOllOWING.tr}' : '${Keystring.COMPANY_FOllOW.tr}',style: TextStyle(color: isFollow ? Colors.black :Colors.white),)
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: SliverTabBarDelegate(
                      TabBar(
                        indicatorColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.blue,
                        tabs: [
                          Tab(
                            child: Text(Keystring.COMPANY_INTRODUCTION.tr),
                          ),
                          Tab(
                            child: Text(
                              '${Keystring.NEWS_RECRUITMENT.tr} ($jobOfCompany) ',
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
                  Tab2(),
                ],
              ),
            ),
          ),
        ));
  }
}

class Tab1 extends ConsumerWidget {
  Tab1({required this.company, Key? key}) : super(key: key);
  CompanyDetail company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isExpanded = ref.watch(isExpandedCompanySeenInforProvider);
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
                  child: Text(Keystring.COMPANY_INTRODUCTION.tr,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
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
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      Text(
                        company.description ?? '',
                        style: const TextStyle(fontSize: 13),
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
                            style: const TextStyle(
                              color: Colors.blue,
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
                margin: const EdgeInsets.only(left: 15),
                child: Text(Keystring.COMPANY_ADDRESS.tr,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          SizedBox(
            height: 10,
            width: screenWidth,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: Text(company.address.toString(),
                    style: const TextStyle(fontSize: 13)),
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
    this.itemCount,
  }) : super(key: key);
  final int? itemCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listActiveJobProvider);
    return _data.when(
      data: (data) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
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
                  MaterialPageRoute(
                      builder: (context) => const JobViewScreen()),
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
          itemCount: itemCount ?? (data.length < 3 ? data.length : 3),
        );
      },
      error: (error, stackTrace) => SizedBox(
        height: 160,
        child: Center(
          child: Text(Keystring.NO_DATA.tr),
        ),
      ),
      loading: () => const SizedBox(
        height: 160,
        child: Center(
          child: CircularProgressIndicator(),
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
