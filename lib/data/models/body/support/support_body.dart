class SupportBody {
  int? id;
  String? fullName;
  String? email;
  String? mobilePhone;
  String? subject;
  String? message;

  SupportBody({
    this.id,
    this.fullName,
    this.email,
    this.mobilePhone,
    this.subject,
    this.message,
  });

  SupportBody.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    mobilePhone = json['mobile_phone'];
    subject = json['subject'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['mobile_phone'] = this.mobilePhone;
    data['subject'] = this.subject;
    data['message'] = this.message;
    return data;
  }
}
