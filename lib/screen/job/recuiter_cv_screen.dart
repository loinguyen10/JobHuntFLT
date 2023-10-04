import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/screen/job/application_view_screen.dart';

import '../../blocs/app_riverpod_object.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';

class ApplicationTodayRecuiterScreen extends ConsumerWidget {
  const ApplicationTodayRecuiterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listRecuiterTodayApplicationProvider);

    if (ref.watch(userLoginProvider)?.role == 'recuiter') {
      Future.delayed(Duration(minutes: 1), () {
        ref.refresh(listRecuiterTodayApplicationProvider);
        log('refresh ne');
      });
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(
                  Keystring.CANDIDATE.tr,
                  textAlign: TextAlign.center,
                  style: textNormalBold,
                ),
              ),
              Expanded(
                child: Text(
                  Keystring.Name_Job.tr,
                  textAlign: TextAlign.center,
                  style: textNormalBold,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(
                  Keystring.SENT_TIME.tr,
                  textAlign: TextAlign.center,
                  style: textNormalBold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        _data.when(
          data: (data) {
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                String name = data[index].job!.name ?? '';
                String nameCandidate = data[index].candidate!.fullName ?? '';
                String sentTime = data[index].sendTime ?? '';

                return Card(
                  elevation: 4,
                  child: ListTile(
                    onTap: () {
                      ref.read(applicationDetailProvider.notifier).state =
                          data[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApplicationViewFullScreen()),
                      );
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Text(
                            nameCandidate,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Text(
                            sentTime,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
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
        _data.value?.length == 0
            ? SizedBox(
                height: 160,
                child: Center(
                  child: Text(Keystring.NO_DATA.tr),
                ),
              )
            : SizedBox(height: 0),
      ],
    );
  }
}
