class SignUpResponse {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? mobileCode;
  String? companyName;
  int? status;

  SignUpResponse({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.mobileCode,
    this.companyName,
    this.status,
  });

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    mobileCode = json['mobile_code'];
    companyName = json['company_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['mobile_code'] = this.mobileCode;
    data['company_name'] = this.companyName;
    data['status'] = this.status;
    return data;
  }
}
