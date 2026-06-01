class ChangePasswordBody {
  String? oldPassword;
  String? newPassword;
  String? newPasswordConfirm;

  ChangePasswordBody({
    this.oldPassword,
    this.newPassword,
    this.newPasswordConfirm,
  });

  ChangePasswordBody.fromJson(Map<String, dynamic> json) {
    oldPassword = json['old_password'];
    newPassword = json['new_password'];
    newPasswordConfirm = json['new_password_confirm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['old_password'] = this.oldPassword;
    data['new_password'] = this.newPassword;
    data['new_password_confirm'] = this.newPasswordConfirm;
    return data;
  }
}
