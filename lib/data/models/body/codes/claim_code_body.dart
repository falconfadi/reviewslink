class ClaimCodeBody {
  String? claimCode;

  ClaimCodeBody({this.claimCode});

  ClaimCodeBody.fromJson(Map<String, dynamic> json) {
    claimCode = json['claim_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claim_code'] = this.claimCode;
    return data;
  }
}
