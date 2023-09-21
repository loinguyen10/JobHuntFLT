class UserDetail {
  String? email;
  String? uid;

  UserDetail({this.email, this.uid});

  UserDetail.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    return data;
  }
}
