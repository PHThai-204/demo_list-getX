import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:demo_list_getx/data/sources/remote/network/app_interceptor.dart';
import 'package:dio/dio.dart';

import '../../../../core/app_utils/app_config.dart';

class DioClient {
  static final Dio dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
    ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true), AppInterceptor()]);

}
