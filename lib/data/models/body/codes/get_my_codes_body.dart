class GetMyCodesBody {
  int? page;
  int? perPage;

  GetMyCodesBody({this.page, this.perPage});

  GetMyCodesBody.fromJson(Map<String, dynamic> json) {
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
