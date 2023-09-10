class AccountDetail {
  int? id;
  String? email;
  String? role;
  String? name;
  String? phone;

  AccountDetail({
    this.id,
    this.email,
    this.role,
    this.name,
    this.phone,
  });

  AccountDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    role = json['role'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['role'] = this.role;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}
