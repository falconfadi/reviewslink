
class UpdateServiceRatingFormBody {

  int? serviceId;
  String? title;
  String? description;
  int? allowComments;
  int? maxStars;

  UpdateServiceRatingFormBody({
    this.serviceId,
    this.title,
    this.description,
    this.allowComments,
    this.maxStars
  });

  UpdateServiceRatingFormBody.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    title = json['rf_title'];
    description = json['rf_description'];
    allowComments = json['rf_allow_comments'];
    maxStars = json['rf_max_stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['rf_title'] = this.title;
    data['rf_description'] = this.description;
    data['rf_allow_comments'] = this.allowComments;
    data['rf_max_stars'] = this.maxStars;
    return data;
  }
}