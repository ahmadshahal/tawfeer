import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';

class ProductAPI {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://b3273d35-bc67-4469-b6e1-1d86090513ef.mock.pstmn.io/api',
      connectTimeout: 10000,
      receiveTimeout: 10000,
      sendTimeout: 10000,
      headers: {
        "Accept": "application/json",
      }
    ),
  );

  Future<List<Product>> index() async {
    try {
      Response response = await dio.get('/products/');
      return (json.decode(response.data) as List).map((e) => Product.fromJson(e)).toList();
    }on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if(e.response != null) {
        if(e.response!.statusCode == 400) {
          throw Exception(json.decode(e.response!.data)['message']);
        }
        else {
          throw Exception(e);
        }
      }
      else {
        // Something happened in setting up or sending the request that triggered an Error.
        throw Exception("No Internet Connection.");
      }
    }
  }
}
