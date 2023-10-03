import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/component/card.dart';

import '../../value/keystring.dart';
import '../../value/style.dart';
import '../job/job_view_screen.dart';

class YourJobSavedScreen extends ConsumerWidget {
  const YourJobSavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listYourFavoriteProvider);

    return SafeArea(
      child: Container(
        color: bgPrimaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                title: Text(Keystring.YOUR_JOB_SAVED.tr),
                backgroundColor: bgPrimaryColor,
                elevation: 0,
                foregroundColor: Colors.black,
              ),
              SizedBox(height: 16),
              _data.when(
                data: (data) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      String avatar = data[index].job!.company!.avatarUrl ?? '';
                      String name = data[index].job!.name ?? '';
                      String nameCompany =
                          data[index].job!.company!.fullname ?? '';
                      String? deadline = data[index].job!.deadline ?? '';
                      String? money = data[index].job!.maxSalary != -1
                          ? '${data[index].job!.maxSalary} ${data[index].job!.currency}'
                          : Keystring.ARGEEMENT.tr;
                      bool active = data[index].job!.active == 1 ? true : false;

                      return Card(
                        shadowColor: Colors.black,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 5,
                        child: GestureDetector(
                          onTap: () {
                            ref.read(jobDetailProvider.notifier).state =
                                data[index].job!;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobViewScreen()));
                          },
                          child: AppFavoriteCard(
                            avatar: avatar,
                            name: name,
                            nameCompany: nameCompany,
                            deadline: deadline,
                            money: money,
                            bgColor: active
                                ? Colors.white
                                : Color.fromARGB(123, 123, 123, 123),
                          ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
