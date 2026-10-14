
class UpdateServiceGoogleReviewBody {

  String? serviceId;
  String? serviceTypeId;
  String? name;
  String? googlePlaceId;

  UpdateServiceGoogleReviewBody({this.serviceId, this.serviceTypeId, this.name, this.googlePlaceId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['service_type_id'] = this.serviceTypeId;
    data['name'] = this.name;
    data['google_place_id'] = this.googlePlaceId;
    return data;
  }
}