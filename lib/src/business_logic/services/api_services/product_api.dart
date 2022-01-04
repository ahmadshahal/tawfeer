import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';
import 'package:tawfeer/src/business_logic/utils/exceptions.dart';

class ProductAPI {
  final String _baseURL = '${Shared.baseURL}/api';

  Future<List<Product>> index() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$_baseURL/products'),
        headers: {
          "Accept": "application/json",
          "Authorization": Shared.token!,
        },
      );
      if (response.statusCode == 200) {
        return ((json.decode(response.body)['Products']) as List)
            .map((e) {
          return Product.fromJson(e as Map<String, dynamic>);
        },)
            .toList();
      } else if (response.statusCode == 401) {
        throw ServerException(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No internet connection");
    }
  }

  Future<List<Product>> myProducts() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$_baseURL/products/myProducts'),
        headers: {
          "Accept": "application/json",
          "Authorization": Shared.token!,
        },
      );
      if (response.statusCode == 200) {
        return ((json.decode(response.body))['My Products'] as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 401) {
        throw ServerException(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No internet connection");
    }
  }

  Future<Product> show(int id) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$_baseURL/products/$id'),
        headers: {
          "Accept": "application/json",
          "Authorization": Shared.token!,
        },
      );
      if (response.statusCode == 200) {
        return Product.fromJson(
            (json.decode(response.body) as Map<String, dynamic>)['Product']);
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw ServerException(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No internet connection");
    }
  }

  Future<void> destroy(int id) async {
    try {
      http.Response response = await http.delete(
        Uri.parse('$_baseURL/products/$id'),
        headers: {
          "Accept": "application/json",
          "Authorization": Shared.token!,
        },
      );
      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw ServerException(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No internet connection");
    }
  }

  Future<void> store(Product product) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$_baseURL/products'));
      request.headers.addAll(
        {
          "Accept": "application/json",
          "Authorization": Shared.token!,
        },
      );
      request.fields.addAll(product.toJson());
      if (product.imgFile != null) {
        var image =
            await http.MultipartFile.fromPath('img', product.imgFile!.path);
        request.files.add(image);
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 400) {
        // throw ServerException((json.decode(response.body) as Map<String, dynamic>)['message']);
        throw ServerException("Wrong form of image");
      } else if (response.statusCode == 401) {
        throw ServerException("Unauthenticated");
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No internet connection");
    }
  }

  Future<void> update(Product product) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$_baseURL/products/${product.id}'));
      request.headers.addAll(
        {
          "Accept": "application/json",
          "Authorization": Shared.token!,
        },
      );
      request.fields.addAll(product.toJson());
      if (product.imgFile != null) {
        var image =
            await http.MultipartFile.fromPath('img', product.imgFile!.path);
        request.files.add(image);
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 400) {
        // throw ServerException((json.decode(response.body) as Map<String, dynamic>)['message']);
        throw ServerException("Wrong Form for image");
      } else if (response.statusCode == 401) {
        throw ServerException("Unauthenticated");
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No internet connection");
    }
  }
}
