
class CreateServiceGoogleReviewBody {

  String? serviceTypeId;
  String? name;
  String? googlePlaceId;

  CreateServiceGoogleReviewBody({this.serviceTypeId, this.name, this.googlePlaceId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_type_id'] = this.serviceTypeId;
    data['name'] = this.name;
    data['google_place_id'] = this.googlePlaceId;
    return data;
  }
}