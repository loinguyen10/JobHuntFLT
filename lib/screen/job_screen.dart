import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/model/job.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import '../blocs/app_riverpod_object.dart';
import '../model/company.dart';

class JobManagerScreen extends ConsumerWidget {
  const JobManagerScreen({super.key});

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
          itemCount: _data.length < 3 ? _data.length : 3,
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

class JobCompanyScreen extends ConsumerWidget {
  const JobCompanyScreen({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listJobProvider);
    List<JobDetail> yourJob = [];

    return _data.when(
      data: (_data) {
        for (var i in _data) {
          if (uid == i.companyId) yourJob.add(i);
        }

        return yourJob.isNotEmpty
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  String name = yourJob[index].name ?? '';
                  String address = yourJob[index].address ?? '';

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
                itemCount: yourJob.length,
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
