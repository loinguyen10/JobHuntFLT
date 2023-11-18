import 'package:jobhunt_ftl/model/company.dart';

class FollowDetail {
  String? code;
  String? companyId;
  String? userId;
  CompanyDetail? company;

  FollowDetail({this.code, this.companyId, this.userId, this.company});

  FollowDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    companyId = json['company_id'];
    userId = json['user_id'];
    company = json['company'] != null ? new CompanyDetail.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['company_id'] = this.companyId;
    data['user_id'] = this.userId;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}