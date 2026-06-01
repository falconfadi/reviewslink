class GetServicesBody {
  int? page;
  int? perPage;

  GetServicesBody({this.page, this.perPage});

  GetServicesBody.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    return data;
  }
}
