class CompanyInfo {
  String? accountId;
  String? address;
  String? avatar;
  String? description;
  String? industry;
  String? name;
  String? phone;
  String? scale;
  String? website;

  CompanyInfo({
    this.accountId,
    this.address,
    this.avatar,
    this.description,
    this.industry,
    this.name,
    this.phone,
    this.scale,
    this.website,
  });
}

class CompanyDetail {
  String? uid;
  String? avatarUrl;
  String? fullname;
  String? email;
  String? phone;
  String? web;
  String? description;
  String? address;
  String? job;
  String? level;
  String? taxcode;
  String? premiumExpiry;

  CompanyDetail({
    this.uid,
    this.avatarUrl,
    this.fullname,
    this.email,
    this.phone,
    this.web,
    this.description,
    this.address,
    this.job,
    this.level,
    this.taxcode,
    this.premiumExpiry,
  });

  CompanyDetail.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    avatarUrl = json['avatar_url'];
    fullname = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    web = json['web'];
    description = json['description'];
    address = json['address'];
    job = json['job'];
    level = json['level'];
    taxcode = json['tax_code'];
    premiumExpiry = json['premium_expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['avatar_url'] = this.avatarUrl;
    data['full_name'] = this.fullname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['web'] = this.web;
    data['description'] = this.description;
    data['address'] = this.address;
    data['job'] = this.job;
    data['level'] = this.level;
    data['tax_code'] = this.taxcode;
    data['premium_expiry'] = this.premiumExpiry;
    return data;
  }
}
