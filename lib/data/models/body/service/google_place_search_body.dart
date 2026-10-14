
class GooglePlaceSearchBody {

  String? q;
  int? limit;
  String? languageCode;
  String? regionCode;

  GooglePlaceSearchBody({this.q, this.limit, this.languageCode, this.regionCode});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['q'] = this.q;
    data['limit'] = this.limit;
    data['language_code'] = this.languageCode;
    if (this.regionCode != null) {
      data['region_code'] = this.regionCode;
    }
    return data;
  }
}