import 'dart:convert';
import 'dart:io';

import 'package:tawfeer/src/business_logic/models/user.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';
import 'package:tawfeer/src/business_logic/utils/exceptions.dart';
import 'package:http/http.dart' as http;

class UserAPI {
  final String baseURL = '${Shared.baseURL}/api';

  Future<String> login(String email, String password) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$baseURL/auth/login'),
        body: {
          'email': email,
          'password': password,
        },
        headers: {
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return (json.decode(response.body) as Map<String, dynamic>)['token'];
      } else if (response.statusCode == 400) {
        throw ServerException((json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No Internet Connection");
    }
  }

  Future<void> logout() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$baseURL/auth/logout'),
        headers: {
          "Accept": "application/json",
          "Authorization": Shared.token!,
        },
      );
      if(response.statusCode == 200) {
        return;
      } else if (response.statusCode == 401) {
        throw ServerException((json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No Internet Connection");
    }
  }

  Future<String> register(String fullName, String email, String password,
      String phoneNumber) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$baseURL/auth/register'),
        body: {
          'fullName': fullName,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
        },
        headers: {
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return (json.decode(response.body) as Map<String, dynamic>)['token'];
      } else if (response.statusCode == 400) {
        throw ServerException((json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No Internet Connection");
    }
  }

  Future<User> profile() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$baseURL/auth/profile'),
        headers: {
          "Accept": "application/json",
          "Authorization": Shared.token!,
        },
      );
      if (response.statusCode == 200) {
        return User.fromJson((json.decode(response.body) as Map<String, dynamic>)['user info']);
      } else if (response.statusCode == 401) {
        throw ServerException((json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No Internet Connection");
    }
  }

  Future<User> showUser(int id) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$baseURL/auth/$id'),
        headers: {
          "Accept": "application/json",
          "Authorization": Shared.token!,
        },
      );
      if (response.statusCode == 200) {
        return User.fromJson((json.decode(response.body) as Map<String, dynamic>)['user']);
      } else if (response.statusCode == 401) {
        throw ServerException((json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No Internet Connection");
    }
  }

  Future<void> validateToken(String token) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$baseURL/auth'),
        headers: {
          "Accept": "application/json",
          "Authorization": token,
        },
      );
      if(response.statusCode == 200) {
        return;
      } else if (response.statusCode == 401) {
        throw ServerException((json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No Internet Connection");
    }
  }
}
