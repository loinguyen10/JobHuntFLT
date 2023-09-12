import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jobhunt_ftl/blocs/app_bloc.dart';
import 'package:jobhunt_ftl/blocs/app_getx.dart';
import 'package:jobhunt_ftl/blocs/app_state.dart';
import 'package:jobhunt_ftl/component/loader_overlay.dart';
import 'package:jobhunt_ftl/model/user.dart';
import 'package:jobhunt_ftl/repository/repository.dart';

import '../blocs/app_event.dart';
import '../model/company.dart';

class CompanyManagerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<InsideBloc, InsideState>(
    //   builder: (context, state) {
    // log('company: ${state.getCompanyStatus}');
    // if (state.getCompanyStatus == GetCompanyStatus.loading) {
    //   Loader.show(context);
    // }

    // if (state.getCompanyStatus == GetCompanyStatus.success) {
    //   Loader.hide();
    //   log('length: ${state.listCompany}');
    // }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("COMPANY INFO"),
        backgroundColor: Colors.black,
      ),
      body: ScreenCompanyManager(
          // listCompany: state.listCompany,
          ),
    ));
    // },
    // );
  }
}

class ScreenCompanyManager extends StatefulWidget {
  ScreenCompanyManager({
    super.key,
    // this.listCompany,
  });
  // List<CompanyInfo>? listCompany;

  @override
  State<ScreenCompanyManager> createState() => _ScreenCompanyManager();
}

class _ScreenCompanyManager extends State<ScreenCompanyManager> {
  final getXX = Get.put(InsideGetX());

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<InsideBloc>(context).add(GetAllCompanyEvent());
    getXX.getCompanyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // getXX.listCompany.toList() != null &&
            Obx(
              () => getXX.listCompany.isNotEmpty
                  ? Flexible(
                      child: ListView.builder(
                        itemBuilder: (_, index) {
                          String name = getXX.listCompany[index].name ?? '';
                          String accId =
                              getXX.listCompany[index].accountId ?? '';
                          //
                          return Card(
                            shadowColor: Colors.grey,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            elevation: 2,
                            child: ListTile(
                              onTap: () {
                                // Future(
                                //   () => Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //         builder: (_) => EditStaffScreen(
                                //               dniStaff:
                                //                   widget.listCompany?[index].dni.toString(),
                                //             )),
                                //   ),
                                // );
                              },
                              title: Column(children: [
                                Text(
                                  '$accId',
                                  overflow: TextOverflow.fade,
                                  maxLines: 3,
                                ),
                                Text(
                                  '$name',
                                  overflow: TextOverflow.fade,
                                  maxLines: 3,
                                ),
                              ]),
                            ),
                          );
                        },
                        itemCount: getXX.listCompany.length,
                      ),
                    )
                  : SizedBox(
                      height: 10,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
