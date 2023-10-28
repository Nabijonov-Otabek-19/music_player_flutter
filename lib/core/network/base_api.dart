import 'package:dio/dio.dart';

// URL = https://storage.googleapis.com/uamp/catalog.json

class BaseApi {
  final _dio = Dio(
    BaseOptions(
      baseUrl: "https://storage.googleapis.com/uamp/",
      validateStatus: (status) => true,
    ),
  );

  Dio get dio => _dio;
}
