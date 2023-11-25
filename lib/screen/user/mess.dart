import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';
import 'package:jobhunt_ftl/screen/user/chatscreen.dart';
import 'package:jobhunt_ftl/screen/user/search_screen.dart';

import '../../blocs/app_riverpod_void.dart';
import '../../component/card.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';

class MessScreen extends ConsumerWidget {
  const MessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mess'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UsersSearchScreen()),
              );
            },
            icon: Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: Theme.of(context).colorScheme.background == Colors.white
              ? bgGradientColor0
              : bgGradientColor1,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Use the same logic for displaying job cards as in Job_Recommend_User
                JobListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class JobListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(listActiveJobProvider);

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
              data[index].address!.substring(data[index].address!.lastIndexOf(',') + 1),
              ref,
            );
            String money = data[index].maxSalary != -1
                ? '${data[index].maxSalary} ${data[index].currency}'
                : Keystring.ARGEEMENT.tr;
            String deadline = data[index].deadline ?? '';

            return GestureDetector(
              onTap: () {
                // Navigate to the ChatScreen when a job is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
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

