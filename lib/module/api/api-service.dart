import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import '../core/info-device/info-device.dart';
import '../core/secure-storage/secure-storage.dart';

class ApiServer {
  final Dio dio;
  final SecureStorage secureStorage;

  ApiServer()
      : secureStorage = SecureStorage(),
        dio = Dio(BaseOptions(
          baseUrl: 'http://192.168.1.71:3000',
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 3000),
        )) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await secureStorage.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        if (e.response?.statusCode == 401) {
          String? refreshToken = await secureStorage.getRefreshToken();
          if (refreshToken != null) {
            try {
              await refreshAccessToken(refreshToken);
              final opts = Options(method: e.requestOptions.method, headers: {
                'Authorization':
                    'Bearer ${await secureStorage.getAccessToken()}'
              });
              final cloneReq = await dio.request(e.requestOptions.path,
                  options: opts,
                  data: e.requestOptions.data,
                  queryParameters: e.requestOptions.queryParameters);
              return handler.resolve(cloneReq);
            } catch (error) {
              await getx.Get.offAllNamed('login');
              return handler.reject(e);
            }
          } else {
            await getx.Get.offAllNamed('login');
          }
        } else if (e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout) {
          print("Connection to backend failed - NestJS server unreachable.");
        } else if (e.type == DioExceptionType.connectionError) {
          await secureStorage.clearTokenData();
          getx.Get.log(
              "Connection to backend failed - NestJS server unreachable");
          await getx.Get.offAllNamed('login');
        }
        return handler.next(e);
      },
    ));
  }

  Future<Response> refreshAccessToken(String token) async {
    try {
      Dio dio = Dio();

      dio.options.baseUrl = 'http://192.168.1.71:3000';
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      Response response = await dio.get('/auth/refresh/access/token');
      final newAccessToken = response.data['accessToken'];
      await secureStorage.saveAccessToken(newAccessToken);
      return response;
    } catch (e) {
      getx.Get.log("refreshAccessToken Failed ${e}");
      return Future.error(e);
    }
  }

  Future<Response> test() async {
    try {
      Response response = await Dio().get("http://192.168.1.71:3000/test");
      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 403) {
        await secureStorage.clearTokenData();
        getx.Get.offAllNamed('login');
        return Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 403,
          statusMessage: 'Forbidden',
          data: {
            'message': 'Access denied.',
            'error': 'Forbidden',
            'statusCode': 403
          },
        );
      } else {
        throw e;
      }
    }
  }

  Future<Response> logoutDevice() async {
    try {
      final response = await dio.delete('/users/logout/device');
      await secureStorage.clearTokenData();
      return response;
    } catch (e) {
      print(e.toString());
      return Future.error(e);
    }
  }

  Future<Response> register(String username, String email, String password,
      String passVerification) async {
    try {
      final info = await getDeviceINFO();
      final data = {
        "username": username,
        "email": email,
        "password": password,
        "password_validation": passVerification,
        "device": [info]
      };
      final response = await dio.post('/users/register', data: data);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> login(
    String username,
    String password,
  ) async {
    try {
      final info = await getDeviceINFO();
      final data = {
        "username": username,
        "password": password,
        "device": [info]
      };
      final response = await dio.post('/users/login', data: data);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> userInfo() async {
    try {
      final response = await dio.get('/users/details');
      return response;
    } catch (e) {
      print(e.toString());
      return Future.error(e);
    }
  }
}
