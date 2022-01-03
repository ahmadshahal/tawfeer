import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';
import 'package:tawfeer/src/business_logic/utils/exceptions.dart';

class ProductAPI {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.8.101:8000/api',
      connectTimeout: 20000,
      receiveTimeout: 20000,
      sendTimeout: 20000,
      headers: {
        "Accept": "application/json",
        "Authorization": Shared.token,
      },
    ),
  );

  Future<List<Product>> index() async {
    try {
      Response response = await dio.get('/products/');
      return (json.decode(response.data) as List)
          .map((e) => Product.fromJson(e))
          .toList();
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

  Future<List<Product>> myProducts() async {
    try {
      Response response = await dio.get('/products/myProducts');
      return ((json.decode(response.data)['My Products : ']) as List)
          .map((e) => Product.fromJson(e))
          .toList();
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

  Future<Product> show(int id) async {
    try {
      Response response = await dio.get('/products/$id');
      return Product.fromJson(json.decode(response.data)["Products"]);
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

  Future<void> destroy(int id) async {
    try {
      await dio.delete('/products/$id');
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

  Future<void> store(Product product) async {
    Map<String, dynamic> data = product.toJson();
    if (product.imgFile != null) {
      data['img'] = await MultipartFile.fromFile(
        product.imgFile!.path,
        filename: product.imgFile!.path.split('/').last,
      );
    }
    try {
      await dio.post(
        '/products/',
        data: FormData.fromMap(data),
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

  Future<void> update(Product product) async {
    Map<String, dynamic> data = product.toJson();
    if (product.imgFile != null) {
      data['img'] = await MultipartFile.fromFile(
        product.imgFile!.path,
        filename: product.imgFile!.path.split('/').last,
      );
    }
    try {
      await dio.put(
        '/products/${product.id}',
        data: FormData.fromMap(data),
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
}
