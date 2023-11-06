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
  }
}
