import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/card.dart';
import 'package:jobhunt_ftl/model/job.dart';
import 'package:jobhunt_ftl/screen/job/job_view_screen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../model/company.dart';

class JobManagerScreen extends ConsumerWidget {
  const JobManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listRecommendJobProvider);

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
          itemCount: data.length < 3 ? data.length : 3,
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

class CVCompanyScreen extends ConsumerWidget {
  const CVCompanyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listCVCompanyProvider);

    return _data.when(
      data: (_data) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            String name = _data[index].name ?? '';
            String address = _data[index].address ?? '';

            return Card(
              shadowColor: Colors.grey,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              elevation: 2,
              child: ListTile(
                onTap: () {
                  //
                },
                title: Column(children: [
                  Text(
                    name,
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                  ),
                  Text(
                    address,
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                  ),
                ]),
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

class JobPostedCompanyScreen extends ConsumerWidget {
  const JobPostedCompanyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listPostJobProvider);

    return _data.when(
      data: (data) {
        // Future.delayed(const Duration(minutes: 1),() => ref.refresh(listPostJobProvider.future));

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
          itemCount: data.length,
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

class JobCompanySuggestionScreen extends ConsumerWidget {
  const JobCompanySuggestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listSuggestionJobProvider);

    return _data.when(
      data: (data) {
        // Future.delayed(const Duration(minutes: 1),() => ref.refresh(listPostJobProvider.future));

        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            String name = data[index].name ?? '';
            String province = getProvinceName(
                data[index]
                    .address!
                    .substring(data[index].address!.lastIndexOf(',') + 1),
                ref);
            String maxSalary = data[index].maxSalary != -1
                ? data[index].maxSalary.toString()
                : Keystring.ARGEEMENT.tr;

            return GestureDetector(
              onTap: () {
                ref.read(jobDetailProvider.notifier).state = data[index];
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JobViewScreen()),
                );
              },
              child: AppJobSuggestionCard(
                name: name,
                province: province,
                maxSalary: maxSalary,
              ),
            );
          },
          itemCount: data.length < 3 ? data.length : 3,
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
