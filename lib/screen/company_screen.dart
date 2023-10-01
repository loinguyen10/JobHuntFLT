import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_void.dart';
import 'package:jobhunt_ftl/component/card.dart';
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
                    child: AppCompanyCard(
                      avatar: avatar,
                      name: name,
                      province: province,
                      job: job,
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
