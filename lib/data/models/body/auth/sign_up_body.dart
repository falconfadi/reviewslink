class SignUpBody {
  String? email;
  String? name;
  String? mobileCode;
  String? mobile;
  String? companyName;
  String? password;

  SignUpBody({
    this.email,
    this.name,
    this.mobileCode,
    this.mobile,
    this.companyName,
    this.password,
  });

  SignUpBody.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    mobileCode = json['mobile_code'];
    mobile = json['mobile'];
    companyName = json['company_name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['mobile_code'] = this.mobileCode;
    data['mobile'] = this.mobile;
    data['company_name'] = this.companyName;
    data['password'] = this.password;
    return data;
  }
}
