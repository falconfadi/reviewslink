class CreateCodeRequestBody {
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  String? companyName;
  int? quantity;
  String? notes;

  CreateCodeRequestBody({
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.companyName,
    this.quantity,
    this.notes,
  });

  CreateCodeRequestBody.fromJson(Map<String, dynamic> json) {
    contactName = json['contact_name'];
    contactEmail = json['contact_email'];
    contactPhone = json['contact_phone'];
    companyName = json['company_name'];
    quantity = json['quantity'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_name'] = this.contactName;
    data['contact_email'] = this.contactEmail;
    data['contact_phone'] = this.contactPhone;
    data['company_name'] = this.companyName;
    data['quantity'] = this.quantity;
    data['notes'] = this.notes;
    return data;
  }
}
