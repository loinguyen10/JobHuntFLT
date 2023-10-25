import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/app_button.dart';
import 'package:jobhunt_ftl/component/edittext.dart';

import '../../blocs/app_riverpod_object.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';

class AllAppicationRecuiterScreen extends ConsumerWidget {
  const AllAppicationRecuiterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _data = ref.watch(listRecuiterApplicationProvider);

    return Container(
      color: appHintColor,
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Colors.black,
            ),
            Expanded(
              child: Row(
                children: [
                  EditTextForm(
                    onChanged: (value) {
                      //
                    },
                    label: Keystring.SEARCH.tr,
                    width: MediaQuery.of(context).size.width,
                  ),
                  AppButton(
                    onPressed: () {
                      //
                    },
                    content: Keystring.SEARCH.tr,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  _data.when(
                    data: (data) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          String name = data[index].job!.name ?? '';
                          String company =
                              data[index].job!.company!.fullname ?? '';
                          String apporve = data[index].apporve ?? '';
                          String sentTime = data[index].sendTime ?? '';
                          String time = apporve.isEmpty
                              ? sentTime
                              : data[index].apporveTime ?? '';

                          return Container(
                            decoration: BoxDecoration(
                                color: apporve == ''
                                    ? Colors.white
                                    : const Color.fromARGB(160, 158, 158, 158),
                                border: Border.all(
                                  width: 1,
                                  color: apporve == ''
                                      ? Colors.grey
                                      : Colors.black,
                                )),
                            child: ExpansionTile(
                              textColor: apporve == ''
                                  ? Colors.black
                                  : apporve == '1'
                                      ? Color.fromARGB(255, 0, 150, 0)
                                      : Color.fromARGB(255, 255, 0, 0),
                              collapsedTextColor: apporve == ''
                                  ? Colors.black
                                  : apporve == '1'
                                      ? Color.fromARGB(255, 0, 150, 0)
                                      : Color.fromARGB(255, 255, 0, 0),
                              tilePadding:
                                  EdgeInsets.only(left: 16, top: 2, bottom: 2),
                              childrenPadding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 6, vertical: 12),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 13,
                                    child: Text(
                                      (index + 1).toString(),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      name,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Text(
                                      time,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Icon(null),
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.2,
                                          child: Text(
                                            '${Keystring.COMPANY.tr}: ${company.toUpperCase()}',
                                            style: textNormal,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          child: Text(
                                            '${Keystring.SENT_TIME.tr}: ${sentTime}',
                                            textAlign: TextAlign.right,
                                            style: textNormal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          '${Keystring.STATUS.tr}:',
                                          style: textNormal,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          apporve == ''
                                              ? Keystring.WAITING.tr
                                                  .toUpperCase()
                                              : apporve == '1'
                                                  ? Keystring.APPORVE.tr
                                                      .toUpperCase()
                                                  : Keystring.REJECT.tr
                                                      .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: apporve == ''
                                                ? Colors.black
                                                : apporve == '1'
                                                    ? Color.fromARGB(
                                                        255, 0, 150, 0)
                                                    : Color.fromARGB(
                                                        255, 255, 0, 0),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
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
          ],
        ),
      ),
    );
  }
}
