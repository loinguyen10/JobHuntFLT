class JobRecommendSetting {
  String? uid;
  String? job;
  int? yearExperience;
  String? workProvince;
  int? minSalary;
  int? maxSalary;

  JobRecommendSetting(
      {this.uid,
      this.job,
      this.yearExperience,
      this.workProvince,
      this.minSalary,
      this.maxSalary,});

  JobRecommendSetting.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    job = json['job'];
    yearExperience = int.parse(json['yearExperience']);
    workProvince = json['workProvince'];
    minSalary = int.parse(json['minSalary']);
    maxSalary = int.parse(json['maxSalary']);
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
