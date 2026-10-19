
class GooglePlaceResponse {

  final String placeId;
  final String placeName;
  final String placeAddress;
  final String businessStatus;
  final String googleReviewUrl;

  GooglePlaceResponse({
    required this.placeId,
    required this.placeName,
    required this.placeAddress,
    required this.businessStatus,
    required this.googleReviewUrl,
  });

  factory GooglePlaceResponse.fromJson(Map<String, dynamic> json) {
    return GooglePlaceResponse(
      placeId: json['place_id'] ?? '',
      placeName: json['place_name'] ?? '',
      placeAddress: json['place_address'] ?? '',
      businessStatus: json['business_status'] ?? '',
      googleReviewUrl: json['google_review_url'] ?? '',
    );
  }
}