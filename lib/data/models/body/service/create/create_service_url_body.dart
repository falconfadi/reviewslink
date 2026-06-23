class CreateServiceUrlBody {
  String? serviceTypeId;
  String? name;
  String? title;
  String? url;

  CreateServiceUrlBody({this.serviceTypeId, this.name, this.title, this.url});

  CreateServiceUrlBody.fromJson(Map<String, dynamic> json) {
    serviceTypeId = json['service_type_id'];
    name = json['name'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_type_id'] = this.serviceTypeId;
    data['name'] = this.name;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}
