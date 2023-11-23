import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/model/company.dart';
import 'package:jobhunt_ftl/screen/user/company_information.dart';

import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../component/card.dart';
import '../../value/keystring.dart';
import '../job/job_view_screen.dart';
class FollowCompanyScreen extends ConsumerWidget {
  const FollowCompanyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listYourFollowProvider);

    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                title: Text(Keystring.YOUR_FOLLOWING_COMPANY.tr),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 16),
              _data.when(
                data: (data) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      String avatar =data[index].company!.avatarUrl ?? '';
                      String nameCompany =
                          data[index].company!.fullname ?? '';
                      String job = data[index].company!.job ?? '';
                      String province = getProvinceName(
                          data[index].company!.address!.substring(
                              data[index].company!.address!.lastIndexOf(',') +
                                  1),
                          ref);


                      return Card(
                        shadowColor: Colors.black,
                        margin:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 5,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CompanyInformation(company:data[index].company!)));
                          },
                          child: AppCompanyCard(
                            avatar: avatar,
                            name: nameCompany,
                            province:province ,
                            job: job,
                          )
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