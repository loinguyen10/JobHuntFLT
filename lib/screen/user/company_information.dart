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
                    backgroundColor:Colors.blue,
                    expandedHeight: 400.0,
                    floating: false,
                    pinned: true,
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Để tạo viền tròn
                          color: Colors.white, // Màu nền trắng
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      title: Visibility(
                        visible: isInnerBoxScrolled,
                        child: Text('Scrollable TabBar Example'),
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
                                                gradient: Theme.of(context).colorScheme.background == Colors.white
                                                    ? bgGradientColor0
                                                    : bgGradientColor1),
                                            child: Container(
                                              child: SizedBox(
                                                  height: 300,
                                                  width: screenWidth,
                                                  child: Image(
                                                    image: AssetImage('assets/image/background_company.jpg'),)
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 2 * screenWidth / 5,
                                            right: 2 * screenWidth / 5,
                                            bottom: 0,
                                            child: SizedBox(
                                              height: 80,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ), // Điều chỉnh độ bo góc
                                                child: Container(
                                                  color: Colors
                                                      .blue,
                                                  child: company!.avatarUrl != ''
                                                      ? Image.network(
                                                      company!.avatarUrl ?? '',
                                                      fit: BoxFit.cover)
                                                      : Icon(
                                                    Icons.apartment,
                                                    size: 96,
                                                  ),// Màu nền xanh
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                    width: screenWidth,
                                    child: Center(
                                        child: Text(
                                      company.fullname.toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: screenWidth,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.language,
                                        size: 18, // Kích thước của biểu tượng
                                        color: Colors
                                            .black, // Màu sắc của biểu tượng
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(company.web.toString(),
                                          style: TextStyle(
                                            fontSize: 12,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: screenWidth,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 18, // Kích thước của biểu tượng
                                        color: Colors
                                            .black, // Màu sắc của biểu tượng
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(company.phone.toString(),
                                          style: TextStyle(
                                            fontSize: 12,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: screenWidth,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.email,
                                        size: 18, // Kích thước của biểu tượng
                                        color: Colors
                                            .black, // Màu sắc của biểu tượng
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(company.email.toString(),
                                          style: TextStyle(
                                            fontSize: 12,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
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
                              Keystring.NEWS_RECRUITMENT.tr +
                                  ' (' +
                                  jobOfCompany.toString() +
                                  ') ',
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
  Tab1({required this.company,Key? key}) : super(key: key);
  CompanyDetail company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isExpanded = ref.watch(isExpandedCompanySeenInforProvider);
    return Container(
      child: SingleChildScrollView(
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
                  margin: EdgeInsets.only(left: 15),
                  child: SizedBox(
                    child: Text(Keystring.COMPANY_INTRODUCTION.tr,
                        style: TextStyle(
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
                Container(
                  child: SizedBox(
                    width: screenWidth,
                    child: Container(
                      width: 9 * screenWidth / 10,
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          Text(
                            company?.description ?? '',
                            style: TextStyle(fontSize: 13),
                            overflow: isExpanded ? null : TextOverflow.ellipsis,
                            maxLines: isExpanded ? null : 8,
                          ),
                          GestureDetector(
                              onTap: () {
                                ref
                                    .read(isExpandedCompanySeenInforProvider
                                        .notifier)
                                    .state = !isExpanded;
                              },
                              child: Text(
                                isExpanded
                                    ? Keystring.COLLAPSE.tr
                                    : Keystring.SEE_MORE.tr,
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ))
                        ],
                      ),
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
                  margin: EdgeInsets.only(left: 15),
                  child: Text(Keystring.COMPANY_ADDRESS.tr,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                  margin: EdgeInsets.only(left: 15),
                  child: Text(company.address.toString(),
                      style: TextStyle(fontSize: 13)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Tab2 extends ConsumerWidget {
  Tab2({
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
