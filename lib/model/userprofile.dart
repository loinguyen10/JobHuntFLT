class UserProfileDetail {
  String? uid;
  String? displayName;
  String? fullName;
  String? avatarUrl;
  String? email;
  String? phone;
  String? address;
  String? birthday;
  String? level;
  int? minSalary;
  int? maxSalary;
  String? currency;
  List<EducationList>? education;

  UserProfileDetail({
    this.uid,
    this.displayName,
    this.fullName,
    this.avatarUrl,
    this.email,
    this.phone,
    this.address,
    this.birthday,
    this.level,
    this.minSalary,
    this.maxSalary,
    this.currency,
    this.education,
  });

  UserProfileDetail.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    displayName = json['display_name'];
    fullName = json['full_name'];
    avatarUrl = json['avatar_url'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    birthday = json['birthday'];
    level = json['level'];
    minSalary = int.parse(json['minSalary'] ?? '0');
    maxSalary = int.parse(json['maxSalary'] ?? '0');
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
