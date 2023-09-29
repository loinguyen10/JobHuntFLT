import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_void.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import '../blocs/app_riverpod_object.dart';
import '../model/company.dart';
import '../value/style.dart';

class CompanyPremiumScreen extends ConsumerWidget {
  const CompanyPremiumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listCompanyProvider);
    List<CompanyDetail> listCompanyPremium = [];

    return _data.when(
      data: (_data) {
        for (var i in _data) {
          if (i.level == 'Premium') listCompanyPremium.add(i);
        }

        return listCompanyPremium.isNotEmpty
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  String name = listCompanyPremium[index].fullname ?? '';
                  String avatar = listCompanyPremium[index].avatarUrl ?? '';
                  String job = listCompanyPremium[index].job ?? '';
                  String province = getProvinceName(
                      listCompanyPremium[index].address!.substring(
                          listCompanyPremium[index].address!.lastIndexOf(',') +
                              1),
                      ref);

                  return GestureDetector(
                    onTap: () {
                      //
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(width: 8),
                          ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(40), // Image radius
                              child: avatar != ''
                                  ? Image.network(
                                      avatar,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.no_accounts_outlined,
                                      size: 80,
                                    ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  name,
                                  overflow: TextOverflow.fade,
                                  maxLines: 3,
                                  style: textNameVCompany,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2, color: Colors.red),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Text(
                                        province,
                                        overflow: TextOverflow.fade,
                                        maxLines: 3,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2, color: Colors.green),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Text(
                                        job,
                                        overflow: TextOverflow.fade,
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: listCompanyPremium.length < 3
                    ? listCompanyPremium.length
                    : 3,
              )
            : SizedBox(
                height: 160,
                child: Center(
                  child: Text(Keystring.NO_DATA.tr),
                ),
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
