class SuccessModelResponse {
  final int status;
  final String message;

  SuccessModelResponse({required this.status, required this.message});

  factory SuccessModelResponse.fromJson(Map<String, dynamic> json) {
    return SuccessModelResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}

SuccessModelResponse successModelFromJson(Map<String, dynamic> json) {
  return SuccessModelResponse.fromJson(json);
}
