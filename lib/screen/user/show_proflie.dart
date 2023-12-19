import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobhunt_ftl/component/border_frame.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';
import 'package:jobhunt_ftl/value/keystring.dart';
import '../../blocs/app_riverpod_object.dart';
import '../../blocs/app_riverpod_void.dart';
import '../../component/edittext.dart';
import '../../component/outline_text.dart';
import '../../value/style.dart';

class ShowProfileScreen extends ConsumerWidget {
  const ShowProfileScreen({super.key, required this.profile});
  final UserProfileDetail profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarProfile = profile.avatarUrl ?? '';
    final recommendProfile = ref.watch(candidateRecommendProvider);
    final listJob = recommendProfile?.job?.split(',');

    return Container(
      decoration: BoxDecoration(
          gradient: Theme.of(context).colorScheme.background == Colors.white
              ? bgGradientColor0
              : bgGradientColor1),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
              ),
              Row(
                children: [
                  SizedBox(width: 24),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(64),
                        child: avatarProfile != ''
                            ? Image.network(avatarProfile, fit: BoxFit.cover)
                            : Icon(
                                Icons.no_accounts_outlined,
                                size: 128,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(width: 32),
                  Expanded(
                    child: AppOutlineText(
                      text: profile.fullName ?? '',
                      fontSize: 22,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 24),
                ],
              ),
              SizedBox(height: 32),
              EditTextForm(
                onChanged: (value) => (),
                label: Keystring.BIRTHDAY.tr,
                content: profile.birthday ?? '',
                readOnly: true,
              ),
              SizedBox(height: 24),
              AppBorderFrame(
                  labelText: Keystring.ADDRESS.tr,
                  child: Text(
                    '${getWardName(profile.address!.substring(profile.address!.indexOf(',') + 1, profile.address!.indexOf(',', profile.address!.indexOf(',') + 1)), ref)}, '
                    '${getDistrictName(profile.address!.substring(profile.address!.lastIndexOf(',', profile.address!.lastIndexOf(',') - 1) + 1, profile.address!.lastIndexOf(',')), ref)},\n'
                    '${getProvinceName(profile.address!.substring(profile.address!.lastIndexOf(',') + 1), ref)}',
                    style: textNormal,
                  )),
              SizedBox(height: 24),
              AppBorderFrame(
                  labelText: Keystring.WANT_JOB.tr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text(
                          '${Keystring.HAS.tr} ${recommendProfile?.yearExperience ?? 0} ${Keystring.Year_Experience.tr.toLowerCase()}',
                          style: textNormal,
                        ),
                      ),
                      listJob != null && listJob.isNotEmpty
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return Card(
                                  shadowColor: Colors.grey,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  elevation: 2,
                                  child: ListTile(
                                    title: Expanded(
                                      child: Text(
                                        listJob[index],
                                        overflow: TextOverflow.fade,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: listJob.length,
                            )
                          : SizedBox(
                              height: 80,
                              child: Text(Keystring.NO_DATA.tr),
                            ),
                    ],
                  )),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
