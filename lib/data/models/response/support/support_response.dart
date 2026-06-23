class SupportResponse {
  int? id;
  int? userId;
  String? fullName;
  String? email;
  String? mobilePhone;
  String? subject;
  String? message;
  String? adminReply;
  int? status;
  String? statusLabel;
  String? createdAt;
  String? updatedAt;

  SupportResponse({
    this.id,
    this.userId,
    this.fullName,
    this.email,
    this.mobilePhone,
    this.subject,
    this.message,
    this.adminReply,
    this.status,
    this.statusLabel,
    this.createdAt,
    this.updatedAt,
  });

  SupportResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    email = json['email'];
    mobilePhone = json['mobile_phone'];
    subject = json['subject'];
    message = json['message'];
    adminReply = json['admin_reply'];
    status = json['status'];
    statusLabel = json['status_label'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['mobile_phone'] = this.mobilePhone;
    data['subject'] = this.subject;
    data['message'] = this.message;
    data['admin_reply'] = this.adminReply;
    data['status'] = this.status;
    data['status_label'] = this.statusLabel;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
