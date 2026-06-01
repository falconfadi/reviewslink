class ResetPasswordBody {
  String? email;
  String? otp;
  String? password;
  String? passwordConfirm;

  ResetPasswordBody({
    this.email,
    this.otp,
    this.password,
    this.passwordConfirm,
  });

  ResetPasswordBody.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
    password = json['password'];
    passwordConfirm = json['password_confirm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['password'] = this.password;
    data['password_confirm'] = this.passwordConfirm;
    return data;
  }
}
