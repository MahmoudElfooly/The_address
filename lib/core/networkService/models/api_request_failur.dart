class ApiRequestFailure {
  String? failureMsg;
  final String? status;

  ApiRequestFailure({this.failureMsg, this.status});

  ApiRequestFailure copyWith(
          {String? status, String? failureMsg, dynamic error}) =>
      ApiRequestFailure(
        status: status ?? this.status,
        failureMsg: failureMsg ?? this.failureMsg,
      );

  factory ApiRequestFailure.fromJson(Map<String, dynamic> json) {
    return ApiRequestFailure(
      status: json["status"],
      failureMsg: json["message"] ?? "Something Went Wrong",
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": failureMsg,
      };

  @override
  String toString() {
    return "message: $failureMsg";
  }
}
