class LoginResponse {
  User? user;

  LoginResponse({this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? adminId;
  String? username;
  String? img;
  int? superAdmin;
  int? adminStatus;
  String? jobTitle;
  int? userId;
  String? userName;
  String? userEmail;
  String? mobile;
  String? mobileCode;
  String? companyName;
  int? userStatus;
  String? creationDate;
  String? token;

  User({
    this.adminId,
    this.username,
    this.img,
    this.superAdmin,
    this.adminStatus,
    this.jobTitle,
    this.userId,
    this.userName,
    this.userEmail,
    this.mobile,
    this.mobileCode,
    this.companyName,
    this.userStatus,
    this.creationDate,
    this.token,
  });

  User.fromJson(Map<String, dynamic> json) {
    adminId = json['admin_id'];
    username = json['username'];
    img = json['img'];
    superAdmin = json['super_admin'];
    adminStatus = json['admin_status'];
    jobTitle = json['job_title'];
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    mobile = json['mobile'];
    mobileCode = json['mobile_code'];
    companyName = json['company_name'];
    userStatus = json['user_status'];
    creationDate = json['creation_date'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admin_id'] = adminId;
    data['username'] = username;
    data['img'] = img;
    data['super_admin'] = superAdmin;
    data['admin_status'] = adminStatus;
    data['job_title'] = jobTitle;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['mobile'] = mobile;
    data['mobile_code'] = mobileCode;
    data['company_name'] = companyName;
    data['user_status'] = userStatus;
    data['creation_date'] = creationDate;
    data['token'] = token;
    return data;
  }
}
