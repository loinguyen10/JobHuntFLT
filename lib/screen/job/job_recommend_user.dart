import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../value/style.dart';
import 'edit_job.dart';

class Job_Recommend_User extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    final role = ref.watch(userLoginProvider)?.role;
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
                elevation: 0,
                actions: [
                  role == 'recuiter'
                      ? Container(
                    margin: EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  JobEditScreen(edit: true)),
                        );
                      },
                      child: Icon(Icons.edit),
                    ),
                  )
                      : SizedBox(width: 0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
