
class UpdateServiceUrlBody {

  String? serviceId;
  String? title;
  String? url;

  UpdateServiceUrlBody({this.serviceId, this.title, this.url});

  UpdateServiceUrlBody.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}
