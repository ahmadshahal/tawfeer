import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tawfeer/src/business_logic/models/user.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';
import 'package:tawfeer/src/business_logic/utils/exceptions.dart';

class UserAPI {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.8.101:8000/api',
      connectTimeout: 20000,
      receiveTimeout: 20000,
      sendTimeout: 20000,
      headers: {
        "Accept": "application/json",
      },
    ),
  );

  Future<String> login(String email, String password) async {
    try {
      Response response = await dio.post(
        '/auth/login',
        data: FormData.fromMap(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      return json.decode(response.data.toString())['token'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw ServerException(json.decode(e.response!.data)['message']);
        } else {
          throw UnknownException('Something went wrong');
        }
      } else {
        // Something happened in setting up or sending the request that triggered an Error.
        throw NetworkException("No Internet Connection");
      }
    }
  }

  Future<void> logout() async {
    try {
      await dio.get(
        '/auth/logout',
        options: Options(
          headers: {
            'token': Shared.token,
          },
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw ServerException(json.decode(e.response!.data)['message']);
        } else {
          throw UnknownException('Something went wrong');
        }
      } else {
        throw NetworkException("No Internet Connection");
      }
    }
  }

  Future<String> register(String fullName, String email, String password,
      String phoneNumber) async {
    try {
      Response response = await dio.post(
        '/auth/register',
        data: FormData.fromMap(
          {
            'fullName': fullName,
            'email': email,
            'password': password,
            'phoneNumber': phoneNumber,
          },
        ),
      );
      return json.decode(response.data)['token'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw ServerException(json.decode(e.response!.data)['message']);
        } else {
          throw UnknownException('Something went wrong');
        }
      } else {
        // Something happened in setting up or sending the request that triggered an Error.
        throw NetworkException("No Internet Connection");
      }
    }
  }

  Future<User> profile() async {
    try {
      Response response = await dio.get(
        '/auth/profile',
        options: Options(headers: {
          'token': Shared.token,
        }),
      );
      return User.fromJson(json.decode(response.data)['user info']);
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw ServerException(json.decode(e.response!.data)['message']);
        } else {
          throw UnknownException('Something went wrong');
        }
      } else {
        throw NetworkException("No Internet Connection");
      }
    }
  }

  Future<User> showUser(int id) async {
    try {
      Response response = await dio.get(
        '/auth/$id',
        options: Options(headers: {
          'token': Shared.token,
        }),
      );
      return User.fromJson(json.decode(response.data)['user']);
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw ServerException(json.decode(e.response!.data)['message']);
        } else {
          throw UnknownException('Something went wrong');
        }
      } else {
        throw NetworkException("No Internet Connection");
      }
    }
  }

  Future<void> validateToken(String token) async {
    try {
      await dio.get(
        '/auth/',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw ServerException(json.decode(e.response!.data)['message']);
        } else {
          print(e);
          throw UnknownException('Something went wrong');
        }
      } else {
        print(e);
        throw NetworkException("No Internet Connection");
      }
    }
  }
}
