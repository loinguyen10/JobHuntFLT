class UserDetail {
  String? email;
  String? uid;
  String? role;

  UserDetail({this.email, this.uid});

  UserDetail.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}
