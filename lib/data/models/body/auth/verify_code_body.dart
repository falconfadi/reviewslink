class VerifyCodeBody {
  String? email;
  String? otp;

  VerifyCodeBody({this.email, this.otp});

  VerifyCodeBody.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['otp'] = this.otp;
    return data;
  }
}
