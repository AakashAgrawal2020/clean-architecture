import 'package:clean_architecture/core/utils/enums.dart';

class ApiResponse<T> {
  ApiStatus? status;
  T? data;
  String? message;

  ApiResponse({this.status, this.data, this.message});

  ApiResponse.initial() : status = ApiStatus.initial;

  ApiResponse.loading() : status = ApiStatus.loading;

  ApiResponse.completed(this.data) : status = ApiStatus.completed;

  ApiResponse.error(this.message) : status = ApiStatus.error;

  @override
  String toString() {
    return 'Status: $status\nMessage: $message\nData: $data';
  }
}
