import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/card.dart';
import 'package:jobhunt_ftl/screen/job/job_view_screen.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';

class JobRecommendListScreen extends ConsumerWidget {
  const JobRecommendListScreen({
    super.key,
    required this.homeMode,
  });

  final bool homeMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listRecommendJobProvider);

    return _data.when(
      data: (data) {
        return ListView.builder(
          physics: homeMode
              ? ClampingScrollPhysics()
              : NeverScrollableScrollPhysics(),
          scrollDirection: homeMode ? Axis.horizontal : Axis.vertical,
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
                ? '${getReduceZeroMoney(data[index].maxSalary ?? 0)} ${data[index].currency}'
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
              child: homeMode
                  ? AppJobHomeCard(
                      avatar: avatar,
                      name: name,
                      companyName: companyName,
                      province: province,
                      money: money,
                      deadline: deadline,
                    )
                  : AppJobCard(
                      avatar: avatar,
                      name: name,
                      companyName: companyName,
                      province: province,
                      money: money,
                      deadline: deadline,
                    ),
            );
          },
          itemCount:
              data.length < 5 ? data.length : (homeMode ? 5 : data.length),
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

class JobBestListScreen extends ConsumerWidget {
  const JobBestListScreen({
    super.key,
    this.itemCount,
  });

  final int? itemCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(listJobBestProvider);

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
                  ? '${getReduceZeroMoney(data[index].maxSalary ?? 0)} ${data[index].currency}'
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
            itemCount:
                data.length < 3 ? data.length : (itemCount ?? data.length),
          )
        : SizedBox(
            height: 160,
            child: Center(
              child: Text(
                Keystring.NO_DATA.tr,
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
                        MaterialPageRoute(
                            builder: (context) => JobViewScreen()),
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

class JobBestWithUser extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView();
  }
}
