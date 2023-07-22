import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  Dio initDio() {
    return Dio(
      BaseOptions(
        baseUrl: "https://bowindo.servehttp.com",
        contentType: "application/json",
      ),
    )..interceptors.add(PrettyDioLogger());
  }
}
