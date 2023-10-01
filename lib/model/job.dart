import 'package:jobhunt_ftl/model/company.dart';

class JobDetail {
  String? code;
  String? name;
  String? companyId;
  int? minSalary;
  int? maxSalary;
  String? currency;
  int? yearExperience;
  int? typeJob;
  int? numberCandidate;
  String? address;
  String? description;
  String? candidateRequirement;
  String? jobBenefit;
  String? tag;
  String? deadline;
  int? active;
  String? level;
  List<CompanyDetail>? company;

  JobDetail({
    this.code,
    this.name,
    this.companyId,
    this.minSalary,
    this.maxSalary,
    this.currency,
    this.yearExperience,
    this.typeJob,
    this.numberCandidate,
    this.address,
    this.description,
    this.candidateRequirement,
    this.jobBenefit,
    this.tag,
    this.deadline,
    this.active,
    this.level,
    this.company,
  });

  JobDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    companyId = json['companyId'];
    minSalary = int.parse(json['minSalary']);
    maxSalary = int.parse(json['maxSalary']);
    currency = json['currency'];
    yearExperience = int.parse(json['yearExperience']);
    typeJob = int.parse(json['typeJob']);
    numberCandidate = int.parse(json['numberCandidate']);
    address = json['address'];
    description = json['description'];
    candidateRequirement = json['candidateRequirement'];
    jobBenefit = json['jobBenefit'];
    tag = json['tag'];
    deadline = json['deadline'];
    active = int.parse(json['active']);
    level = json['level'];
    if (json['company'] != null) {
      company = <CompanyDetail>[];
      json['company'].forEach((v) {
        company!.add(new CompanyDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['companyId'] = this.companyId;
    data['minSalary'] = this.minSalary;
    data['maxSalary'] = this.maxSalary;
    data['currency'] = this.currency;
    data['yearExperience'] = this.yearExperience;
    data['typeJob'] = this.typeJob;
    data['numberCandidate'] = this.numberCandidate;
    data['address'] = this.address;
    data['description'] = this.description;
    data['candidateRequirement'] = this.candidateRequirement;
    data['jobBenefit'] = this.jobBenefit;
    data['tag'] = this.tag;
    data['deadline'] = this.deadline;
    data['active'] = this.active;
    data['level'] = this.level;
    if (this.company != null) {
      data['company'] = this.company!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
