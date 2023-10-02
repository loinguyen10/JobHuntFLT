import 'package:jobhunt_ftl/model/userprofile.dart';

class CVDetail {
  String? code;
  String? cvUrl;
  String? userId;
  String? type;
  String? createTime;
  String? updateTime;
  UserProfileDetail? profile;

  CVDetail({
    this.code,
    this.cvUrl,
    this.userId,
    this.type,
    this.createTime,
    this.updateTime,
    this.profile,
  });

  CVDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    cvUrl = json['cv_url'];
    userId = json['user_id'];
    type = json['type'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    profile = json['profile'] != null
        ? new UserProfileDetail.fromJson(json['profile'])
        : null;
  }
}
