import 'package:dio/dio.dart';
import '../../utils/utils.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.badResponse:
        showToastMessage('Bad response error');
        break;
      case DioExceptionType.connectionError:
        showToastMessage('Connection error');
        break;
      default:
        showToastMessage('Some error');
        break;
    }
    handler.next(err);
  }
}
