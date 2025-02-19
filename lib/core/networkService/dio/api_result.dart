import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

/// This class defines the states of the request
/// Success : the request succeed, return the data as a generic type
/// Failure : the request failed, return error message as string
@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;

  const factory ApiResult.failure(String error) = Failure<T>;
}
