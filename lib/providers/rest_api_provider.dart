import 'package:dio/dio.dart';

class RestApiProvider {
  static String _baseUrl = "https://cupboard-54d1c-default-rtdb.firebaseio.com";

  static Dio _dio = new Dio();

  static RestApiProvider? _instance;

  RestApiProvider._internal() {
    _configureDio();
  }

  factory RestApiProvider() {
    if (_instance == null) {
      _instance = RestApiProvider._internal();
    }
    return _instance!;
  }

  void _configureDio() {
    // Base del url
    _dio.options.baseUrl = _baseUrl;

    // Configurar Headers
    /*
    _dio.options.headers = {
      'x-token': LocalStorage.prefs.getString('token') ?? ''
    };
    */
  }

  Future<dynamic> get(String path) async {
    try {
      final resp = await _dio.get(path);
      return resp.data;
    } catch (e) {
      print(e);
      throw ('Error en el GET');
    }
  }

  Future post(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.post(path, data: formData);
      return resp.data;
    } catch (e) {
      print(e);
      throw ('Error en el POST');
    }
  }

  Future put(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.put(path, data: formData);
      return resp.data;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el PUT $e');
    }
  }

  Future delete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.delete(path, data: formData);
      return resp.data;
    } catch (e) {
      print(e);
      throw ('Error en el delete');
    }
  }
}
