class JobRecommendSetting {
  String? uid;
  String? gender;
  String? job;
  String? educationId;
  String? yearExperience;
  String? workProvince;
  int? minSalary;
  int? maxSalary;
  String? currency;
  List<EducationList>? education;

  JobRecommendSetting(
      {this.uid,
      this.gender,
      this.job,
      this.educationId,
      this.yearExperience,
      this.workProvince,
      this.minSalary,
      this.maxSalary,
      this.currency,
      this.education});

  JobRecommendSetting.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    gender = json['gender'];
    job = json['job'];
    educationId = json['educationId'];
    yearExperience = json['yearExperience'];
    workProvince = json['workProvince'];
    minSalary = int.parse(json['minSalary']);
    maxSalary = int.parse(json['maxSalary']);
    currency = json['currency'];
    if (json['education'] != null) {
      education = <EducationList>[];
      json['education'].forEach((v) {
        education!.add(new EducationList.fromJson(v));
      });
    }
  }
}

class EducationList {
  String? id;
  String? title;
  String? title_en;

  EducationList({
    this.id,
    this.title,
    this.title_en,
  });

  EducationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    title_en = json['title_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['title_en'] = title_en;
    return data;
  }
}

class CurrencyList {
  String? code;
  String? name;
  String? name_vi;
  String? symbol;

  CurrencyList({
    this.code,
    this.name,
    this.name_vi,
    this.symbol,
  });

  CurrencyList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    name_vi = json['name_vi'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['name'] = name;
    data['name_vi'] = name_vi;
    data['symbol'] = symbol;
    return data;
  }
}
