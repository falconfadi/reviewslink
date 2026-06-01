class MyQrRequestResponse {
  int? id;
  int? userId;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  String? companyName;
  int? quantity;
  String? notes;
  int? status;
  String? statusLabel;
  String? adminNote;
  String? createdAt;
  String? updatedAt;

  MyQrRequestResponse({
    this.id,
    this.userId,
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.companyName,
    this.quantity,
    this.notes,
    this.status,
    this.statusLabel,
    this.adminNote,
    this.createdAt,
    this.updatedAt,
  });

  MyQrRequestResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    contactName = json['contact_name'];
    contactEmail = json['contact_email'];
    contactPhone = json['contact_phone'];
    companyName = json['company_name'];
    quantity = json['quantity'];
    notes = json['notes'];
    status = json['status'];
    statusLabel = json['status_label'];
    adminNote = json['admin_note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['contact_name'] = this.contactName;
    data['contact_email'] = this.contactEmail;
    data['contact_phone'] = this.contactPhone;
    data['company_name'] = this.companyName;
    data['quantity'] = this.quantity;
    data['notes'] = this.notes;
    data['status'] = this.status;
    data['status_label'] = this.statusLabel;
    data['admin_note'] = this.adminNote;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
