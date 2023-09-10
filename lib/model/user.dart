class UserDetail {
  String? displayName;
  String? email;
  // bool? isEmailVerified;
  // bool? isAnonymous;
  // UserMetadata? metadata;
  String? phoneNumber;
  String? photoURL;
  String? uid;

  // UserDetail(
  //     {this.displayName,
  //     this.email,
  //     this.phoneNumber,
  //     this.photoURL,
  //     this.uid});

  UserDetail({this.email, this.uid});

  UserDetail.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    // displayName = json['displayName'];
    // phoneNumber = json['phoneNumber'];
    // photoURL = json['photoURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    // data['displayName'] = this.displayName;
    // data['phoneNumber'] = this.phoneNumber;
    // data['photoURL'] = this.photoURL;
    return data;
  }
}
