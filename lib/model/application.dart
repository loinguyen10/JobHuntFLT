import 'package:jobhunt_ftl/model/job.dart';
import 'package:jobhunt_ftl/model/userprofile.dart';

class ApplicationDetail {
  String? code;
  String? cvUrl;
  String? jobId;
  String? candidateId;
  String? companyId;
  String? sendTime;
  String? approve;
  String? approveTime;
  String? interviewTime;
  JobDetail? job;
  UserProfileDetail? candidate;

  ApplicationDetail(
      {this.code,
      this.cvUrl,
      this.jobId,
      this.candidateId,
      this.companyId,
      this.sendTime,
      this.approve,
      this.approveTime,
      this.interviewTime,
      this.job,
      this.candidate});

  ApplicationDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    cvUrl = json['cv_url'];
    jobId = json['job_id'];
    candidateId = json['candidate_id'];
    companyId = json['company_id'];
    sendTime = json['send_time'];
    approve = json['approve'];
    approveTime = json['approve_time'];
    interviewTime = json['interview_time'];
    job = json['job'] != null ? new JobDetail.fromJson(json['job']) : null;
    candidate = json['candidate'] != null
        ? new UserProfileDetail.fromJson(json['candidate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['cv_url'] = this.cvUrl;
    data['job_id'] = this.jobId;
    data['candidate_id'] = this.candidateId;
    data['company_id'] = this.companyId;
    data['send_time'] = this.sendTime;
    data['approve'] = this.approve;
    data['approve_time'] = this.approveTime;
    data['interview_time'] = this.interviewTime;
    // if (this.job != null) {
    //   data['job'] = this.job!.toJson();
    // }
    // if (this.candidate != null) {
    //   data['candidate'] = this.candidate!.toJson();
    // }
    return data;
  }
}
