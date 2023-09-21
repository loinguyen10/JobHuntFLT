class UserProfileDetail {
  String? id;
  String? avatarUrl;
  String? cvUrl;
  List<EducationList>? education;
  String? maxSalary;
  String? minSalary;
  CurrencyList? currency;
  List<String>? skillList;
  String? typeSalary;
  String? address;
  String? birthday;
  String? email;
  String? displayName;
  String? fullName;
  String? phone;

  UserProfileDetail({
    this.id,
    this.avatarUrl,
    this.displayName,
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.birthday,
    this.cvUrl,
    this.education,
    this.maxSalary,
    this.minSalary,
    this.currency,
    this.skillList,
    this.typeSalary,
  });
}

class EducationList {
  String? id;
  String? title;

  EducationList({
    this.id,
    this.title,
  });

  EducationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
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
