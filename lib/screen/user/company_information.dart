import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/value/keystring.dart';

class CompanyInfor extends ConsumerWidget{
  const CompanyInfor({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isExpanded = false;
    double screenWidth = MediaQuery.of(context).size.width;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                    child:
                    Container(
                      child: SizedBox(
                        height: 300,
                        width: screenWidth,
                        child: Stack(

                        ),
                      ),
                    )
                ),
                Expanded(
                  flex: 2,
                    child: Container(
                      child: SizedBox(
                        height: 200,
                        width: screenWidth,
                      ),
                    )
                ),
                Expanded(
                  flex: 3,
                    child: Container(
                      child: SizedBox(
                        height: 400,
                        width: screenWidth,
                        child: Container(
                          width: 9 * screenWidth / 10,
                          margin: EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              Text(
                                'The Blood of Youth (2022),xem phim The Blood of Youth (2022),The Blood of Youth (2022) xem phim,The Blood of Youth (2022) lồng tiếng,The Blood of Youth (2022) thuyết minh,The Blood of Youth (2022) vietsub,Thiếu Niên Ca Hành,xem phim Thiếu Niên Ca Hành,Thiếu Niên Ca Hành xem phim,Thiếu Niên Ca Hành thuyết minh,Thiếu Niên Ca Hành vietsub,Thiếu Niên Ca Hành lồng tiếng,Thiếu Niên Ca Hành tập 1,Thiếu Niên Ca Hành tập 2,Thiếu Niên Ca Hành tập 3,Thiếu Niên Ca Hành tập 4,Thiếu Niên Ca Hành tập 5,Thiếu Niên Ca Hành tập 6,Thiếu Niên Ca Hành tập 7,Thiếu Niên Ca Hành tập 8,Thiếu Niên Ca Hành tập 9,Thiếu Niên Ca Hành tập 10,Thiếu Niên Ca Hành tập 11,Thiếu Niên Ca Hành tập 12,Thiếu Niên Ca Hành tập 13,Thiếu Niên Ca Hành tập 14,Thiếu Niên Ca Hành tập 15,Thiếu Niên Ca Hành tập 16,Thiếu Niên Ca Hành tập 17,Thiếu Niên Ca Hành tập 18,Thiếu Niên Ca Hành tập 19,Thiếu Niên Ca Hành tập 20,Thiếu Niên Ca Hành tập 21,Thiếu Niên Ca Hành tập 22,Thiếu Niên Ca Hành tập 23,Thiếu Niên Ca Hành tập 24,Thiếu Niên Ca Hành tập 25,Thiếu Niên Ca Hành tập 26,Thiếu Niên Ca Hành tập 27,Thiếu Niên Ca Hành tập 28,Thiếu Niên Ca Hành tập 29,Thiếu Niên Ca Hành tập 30,Thiếu Niên Ca Hành tập 31,Thiếu Niên Ca Hành tập 32,Thiếu Niên Ca Hành tập 33,Thiếu Niên Ca Hành tập 34,Thiếu Niên Ca Hành tập 35,Thiếu Niên Ca Hành tập 36,Thiếu Niên Ca Hành tập 37,Thiếu Niên Ca Hành tập 38,Thiếu Niên Ca Hành tập 39,Thiếu Niên Ca Hành tập 40',
                                style: TextStyle(fontSize: 13),
                                overflow:
                                isExpanded ? null : TextOverflow.ellipsis,
                                maxLines: isExpanded ? null : 3,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    // setState(() {
                                    //   isExpanded =
                                    //   !isExpanded;
                                    // });

                                  },
                                  child: Text(
                                    isExpanded ? Keystring.COLLAPSE.tr : Keystring.SEE_MORE.tr,
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
                ),
              ],
            ),
          ),
        );
  }
}