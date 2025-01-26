import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
            errorMessage: 'Connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'Send timeout with API server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'Receive timeout with API server');
      case DioExceptionType.badCertificate:
        return ServerFailure(errorMessage: 'Bad certificate with API server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromBadResponse(
            dioError.response!.statusCode, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(
            errorMessage: 'Request to Api server was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure(errorMessage: 'Connection error with API server');
      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure(errorMessage: 'No internet connection');
        }
        return ServerFailure(
            errorMessage: 'Unexpected error, Please try again.');
    }
  }

  factory ServerFailure.fromBadResponse(int? statusCode, dynamic badResponse) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errorMessage: badResponse['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure(
          errorMessage: 'Your request is not found. Please try again later');
    } else if (statusCode == 500) {
      return ServerFailure(
          errorMessage: 'Internal server error. Please try again later');
    } else {
      return ServerFailure(
          errorMessage:
              'Oops there was an error. Please try again, bad status code $statusCode');
    }
  }
}
