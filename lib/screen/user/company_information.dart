import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../component/card.dart';
import '../../value/style.dart';
import '../job/job_view_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(ProviderScope(
//       child: Scaffold(
//           body:  CompanyInfor()
//       )
//   ));
// }

class CompanyInformation extends ConsumerWidget {
  CompanyInformation({required this.companyId, Key? key}) : super(key: key);
  var companyId;

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
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                elevation: 0,
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
              ),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: screenWidth,
                        height: 215,
                        child: Stack(
                          children: [
                            Container(
                              color: Colors.red,
                              child: SizedBox(
                                  height: 200,
                                  width: screenWidth,
                                  child: Container()),
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
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ), // Điều chỉnh độ bo góc
                                  child: Container(
                                    color: Colors.blue, // Màu nền xanh
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
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
                        'Công ty Cổ phần Atomi Digital',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
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
                          color: Colors.black, // Màu sắc của biểu tượng
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(companyId.toString(),
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
                          color: Colors.black, // Màu sắc của biểu tượng
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(companyId.toString(),
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
                      child: Center(
                          child: Text(
                        'Công ty Cổ phần Atomi Digital',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TabBar(tabs: [
                Tab(
                    text: Keystring.COMPANY_INTRODUCTION +
                        ' (' +
                        jobOfCompany.toString() +
                        ')'),
                Tab(text: Keystring.NEWS_RECRUITMENT),
              ]),
              TabBarView(children: [
                Tab1(),
                // Tab2(),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class Tab1 extends ConsumerWidget {
  Tab1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isExpanded = ref.watch(isExpandedCompanySeenInforProvider);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
            width: screenWidth,
          ),
          Row(
            children: [
              Text(Keystring.COMPANY_INTRODUCTION,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
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
                child: SizedBox(
                  height: 500,
                  width: screenWidth,
                  child: Container(
                    width: 9 * screenWidth / 10,
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Text(
                          'The Blood of Youth (2022),xem phim The Blood of Youth (2022),The Blood of Youth (2022) xem phim,The Blood of Youth (2022) lồng tiếng,The Blood of Youth (2022) thuyết minh,The Blood of Youth (2022) vietsub,Thiếu Niên Ca Hành,xem phim Thiếu Niên Ca Hành,Thiếu Niên Ca Hành xem phim,Thiếu Niên Ca Hành thuyết minh,Thiếu Niên Ca Hành vietsub,Thiếu Niên Ca Hành lồng tiếng,Thiếu Niên Ca Hành tập 1,Thiếu Niên Ca Hành tập 2,Thiếu Niên Ca Hành tập 3,Thiếu Niên Ca Hành tập 4,Thiếu Niên Ca Hành tập 5,Thiếu Niên Ca Hành tập 6,Thiếu Niên Ca Hành tập 7,Thiếu Niên Ca Hành tập 8,Thiếu Niên Ca Hành tập 9,Thiếu Niên Ca Hành tập 10,Thiếu Niên Ca Hành tập 11,Thiếu Niên Ca Hành tập 12,Thiếu Niên Ca Hành tập 13,Thiếu Niên Ca Hành tập 14,Thiếu Niên Ca Hành tập 15,Thiếu Niên Ca Hành tập 16,Thiếu Niên Ca Hành tập 17,Thiếu Niên Ca Hành tập 18,Thiếu Niên Ca Hành tập 19,Thiếu Niên Ca Hành tập 20,Thiếu Niên Ca Hành tập 21,Thiếu Niên Ca Hành tập 22,Thiếu Niên Ca Hành tập 23,Thiếu Niên Ca Hành tập 24,Thiếu Niên Ca Hành tập 25,Thiếu Niên Ca Hành tập 26,Thiếu Niên Ca Hành tập 27,Thiếu Niên Ca Hành tập 28,Thiếu Niên Ca Hành tập 29,Thiếu Niên Ca Hành tập 30,Thiếu Niên Ca Hành tập 31,Thiếu Niên Ca Hành tập 32,Thiếu Niên Ca Hành tập 33,Thiếu Niên Ca Hành tập 34,Thiếu Niên Ca Hành tập 35,Thiếu Niên Ca Hành tập 36,Thiếu Niên Ca Hành tập 37,Thiếu Niên Ca Hành tập 38,Thiếu Niên Ca Hành tập 39,Thiếu Niên Ca Hành tập 40',
                          style: TextStyle(fontSize: 13),
                          overflow: isExpanded ? null : TextOverflow.ellipsis,
                          maxLines: isExpanded ? null : 10,
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
              )),
            ],
          ),
          SizedBox(
            height: 10,
            width: screenWidth,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: SizedBox(
              height: 1,
              width: screenWidth,
            ),
          ),
          SizedBox(
            height: 10,
            width: screenWidth,
          ),
          Row(
            children: [
              Text(Keystring.COMPANY_ADDRESS,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(
            height: 10,
            width: screenWidth,
          ),
          Row(
            children: [
              Text(Keystring.COMPANY_ADDRESS, style: TextStyle(fontSize: 13))
            ],
          ),
        ],
      ),
    );
  }
}
// class Tab2 extends ConsumerWidget{
//   Tab2({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final _data = ref.watch(listRecommendJobProvider);

//     return _data.when(
//       data: (data) {
//         return ListView.builder(
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemBuilder: (_, index) {
//             String avatar = data[index].company?.avatarUrl ?? '';
//             String name = data[index].name ?? '';
//             String companyName = data[index].company?.fullname ?? '';
//             String province = getProvinceName(
//                 data[index]
//                     .address!
//                     .substring(data[index].address!.lastIndexOf(',') + 1),
//                 ref);
//             String money = data[index].maxSalary != -1
//                 ? '${data[index].maxSalary} ${data[index].currency}'
//                 : Keystring.ARGEEMENT.tr;
//             String deadline = data[index].deadline ?? '';

//             return GestureDetector(
//               onTap: () {
//                 ref.read(jobDetailProvider.notifier).state = data[index];
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => JobViewScreen()),
//                 );
//               },
//               child: AppJobCard(
//                 avatar: avatar,
//                 name: name,
//                 companyName: companyName,
//                 province: province,
//                 money: money,
//                 deadline: deadline,
//               ),
//             );
//           },
//           itemCount: data.length < 3 ? data.length : 3,
//         );
//       },
//       error: (error, stackTrace) => SizedBox(
//         height: 160,
//         child: Center(
//           child: Text(Keystring.NO_DATA.tr),
//         ),
//       ),
//       loading: () => const SizedBox(
//         height: 160,
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }
