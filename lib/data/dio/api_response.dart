class ApiResponse<T> {
  final int code;
  final String message;
  final bool status;
  final T? body;

  ApiResponse({
    required this.code,
    required this.message,
    required this.status,
    this.body,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJsonT,
  ) {
    return ApiResponse(
      code: json['code'] ?? "",
      message: json['message'] ?? "",
      status: json['status'] ?? "",
      body: fromJsonT != null ? fromJsonT(json['body']) : json['body'],
    );
  }
}
