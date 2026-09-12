
class CreateServiceUrlBody {

  String? serviceTypeId;
  String? title;
  String? url;

  CreateServiceUrlBody({this.serviceTypeId, this.title, this.url});

  CreateServiceUrlBody.fromJson(Map<String, dynamic> json) {
    serviceTypeId = json['service_type_id'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_type_id'] = this.serviceTypeId;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}
