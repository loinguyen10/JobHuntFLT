import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_void.dart';
import 'package:jobhunt_ftl/component/card.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../model/company.dart';
import '../../value/style.dart';
import 'company_information.dart';

class CompanyPremiumScreen extends ConsumerWidget {
  const CompanyPremiumScreen({super.key, this.itemCount});

  final int? itemCount;

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
                  var tag = job.split(',');
                  String province = getProvinceName(
                      listCompanyPremium[index].address!.substring(
                          listCompanyPremium[index].address!.lastIndexOf(',') +
                              1),
                      ref);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompanyInformation(
                              company: listCompanyPremium[index],
                            ),
                          ));
                    },
                    child: AppCompanyCard(
                      avatar: avatar,
                      name: name,
                      province: province,
                      job: tag[0],
                    ),
                  );
                },
                itemCount: listCompanyPremium.length < 3
                    ? listCompanyPremium.length
                    : (itemCount ?? listCompanyPremium.length),
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

class AllCompanyScreen extends ConsumerWidget {
  const AllCompanyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listCompanyProvider);

    return _data.when(
      data: (_data) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            String name = _data[index].fullname ?? '';
            String avatar = _data[index].avatarUrl ?? '';
            String job = _data[index].job ?? '';
            var tag = job.split(',');
            String province = getProvinceName(
                _data[index]
                    .address!
                    .substring(_data[index].address!.lastIndexOf(',') + 1),
                ref);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompanyInformation(
                        company: _data[index],
                      ),
                    ));
              },
              child: AppCompanyCard(
                avatar: avatar,
                name: name,
                province: province,
                job: tag[0],
              ),
            );
          },
          itemCount: _data.length,
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
