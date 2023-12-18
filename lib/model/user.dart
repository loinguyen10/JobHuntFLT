class UserDetail {
  String? email;
  String? uid;
  String? role;
  String? status;

  UserDetail({this.uid, this.email, this.role, this.status});

  UserDetail.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    role = json['role'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['role'] = this.role;
    data['status'] = this.status;
    return data;
  }
}
