class AssignCodeToServiceBody {
  int? codeId;
  int? serviceId;

  AssignCodeToServiceBody({this.codeId, this.serviceId});

  AssignCodeToServiceBody.fromJson(Map<String, dynamic> json) {
    codeId = json['code_id'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code_id'] = this.codeId;
    data['service_id'] = this.serviceId;
    return data;
  }
}
