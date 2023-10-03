import 'package:jobhunt_ftl/model/job.dart';

class FavoriteDetail {
  String? code;
  String? jobId;
  String? userId;
  JobDetail? job;

  FavoriteDetail({this.code, this.jobId, this.userId, this.job});

  FavoriteDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    jobId = json['job_id'];
    userId = json['user_id'];
    job = json['job'] != null ? new JobDetail.fromJson(json['job']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['job_id'] = this.jobId;
    data['user_id'] = this.userId;
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    return data;
  }
}
