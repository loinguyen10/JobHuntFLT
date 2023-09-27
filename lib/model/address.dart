class ProvinceList {
  String? code;
  String? name;
  String? countryCode;

  ProvinceList({this.code, this.name, this.countryCode});

  ProvinceList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    return data;
  }
}

class DistrictList {
  String? code;
  String? name;
  String? fullName;
  String? provinceCode;

  DistrictList({this.code, this.name, this.fullName, this.provinceCode});

  DistrictList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    fullName = json['full_name'];
    provinceCode = json['province_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['full_name'] = this.fullName;
    data['province_code'] = this.provinceCode;
    return data;
  }
}

class WardList {
  String? code;
  String? name;
  String? fullName;
  String? districtCode;

  WardList({this.code, this.name, this.fullName, this.districtCode});

  WardList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    fullName = json['full_name'];
    districtCode = json['district_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['full_name'] = this.fullName;
    data['district_code'] = this.districtCode;
    return data;
  }
}
