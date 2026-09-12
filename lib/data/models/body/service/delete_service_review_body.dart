
class DeleteServiceReviewBody {

  int? reviewId;

  DeleteServiceReviewBody({this.reviewId});

  DeleteServiceReviewBody.fromJson(Map<String, dynamic> json) {
    reviewId = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.reviewId;
    return data;
  }
}
