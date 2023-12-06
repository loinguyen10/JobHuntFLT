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
  String? premiumExpiry;

  UserProfileDetail(
      {this.uid,
      this.displayName,
      this.fullName,
      this.avatarUrl,
      this.email,
      this.phone,
      this.address,
      this.birthday,
      this.level,
      this.premiumExpiry});

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
    premiumExpiry = json['premium_expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['display_name'] = this.displayName;
    data['full_name'] = this.fullName;
    data['avatar_url'] = this.avatarUrl;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['birthday'] = this.birthday;
    data['level'] = this.level;
    data['premium_expiry'] = this.premiumExpiry;
    return data;
  }
}
