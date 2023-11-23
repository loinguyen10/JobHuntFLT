import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../component/card.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';
import 'job_view_screen.dart';

class JobRecommendUser extends ConsumerWidget {
  const JobRecommendUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listActiveJobProvider);
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
                title: Text(Keystring.RECOMMEND_JOB.tr),
                elevation: 0,
              ),
              _data.when(
                data: (data) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      String avatar = data[index].company?.avatarUrl ?? '';
                      String name = data[index].name ?? '';
                      String companyName = data[index].company?.fullname ?? '';
                      String province = getProvinceName(
                          data[index].address!.substring(
                              data[index].address!.lastIndexOf(',') + 1),
                          ref);
                      String money = data[index].maxSalary != -1
                          ? '${data[index].maxSalary} ${data[index].currency}'
                          : Keystring.ARGEEMENT.tr;
                      String deadline = data[index].deadline ?? '';

                      return GestureDetector(
                        onTap: () {
                          ref.read(jobDetailProvider.notifier).state =
                              data[index];
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
