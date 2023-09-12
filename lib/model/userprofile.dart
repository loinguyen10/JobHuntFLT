class UserProfileDetail {
  String? id;
  String? avatarUrl;
  String? cvUrl;
  List<EducationList>? education;
  String? maxSalary;
  String? minSalary;
  List<ProfessionList>? profession;
  List<String>? skillList;
  String? typeSalary;
  String? address;
  String? birthday;
  String? email;
  String? displayName;
  String? fullName;
  String? phone;

  UserProfileDetail({
    this.id,
    this.avatarUrl,
    this.displayName,
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.birthday,
    this.cvUrl,
    this.education,
    this.maxSalary,
    this.minSalary,
    this.profession,
    this.skillList,
    this.typeSalary,
  });
}

class EducationList {
  int? id;
  String? title;

  EducationList({
    this.id,
    this.title,
  });
}

class ProfessionList {
  int? id;
  String? title;

  ProfessionList({
    this.id,
    this.title,
  });
}
