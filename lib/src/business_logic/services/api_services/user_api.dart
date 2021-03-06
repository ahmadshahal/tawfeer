import 'dart:convert';
import 'dart:io';

import 'package:tawfeer/src/business_logic/models/user.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';
import 'package:tawfeer/src/business_logic/utils/exceptions.dart';
import 'package:http/http.dart' as http;

class UserAPI {
  final String _baseURL = '${Shared.baseURL}/api';

  Future<String> login(String email, String password) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$_baseURL/auth/login'),
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
        throw ServerException(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No internet connection");
    }
  }

  Future<void> logout() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$_baseURL/auth/logout'),
        headers: {
          "Accept": "application/json",
          "Authorization": Shared.token!,
        },
      );
      if (response.statusCode == 200) {
        return;
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

  Future<String> register(String fullName, String email, String password,
      String phoneNumber) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$_baseURL/auth/register'),
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
        throw ServerException(
            (json.decode(response.body) as Map<String, dynamic>)['message']);
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No internet connection");
    }
  }

  Future<User> profile() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$_baseURL/auth/profile'),
        headers: {
          "Accept": "application/json",
          "Authorization": Shared.token!,
        },
      );
      if (response.statusCode == 200) {
        return User.fromJson(
            (json.decode(response.body) as Map<String, dynamic>)['user info']);
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

  Future<User> showUser(int id) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$_baseURL/auth/$id'),
        headers: {
          "Accept": "application/json",
          "Authorization": Shared.token!,
        },
      );
      if (response.statusCode == 200) {
        return User.fromJson(
            (json.decode(response.body) as Map<String, dynamic>)['user']);
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

  Future<void> validateToken(String token) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$_baseURL/auth'),
        headers: {
          "Accept": "application/json",
          "Authorization": token,
        },
      );
      if (response.statusCode == 200) {
        return;
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

  Future<void> updateImage(File imgFile) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$_baseURL/auth/updatePhoto'));
      request.headers.addAll(
        {
          "Accept": "application/json",
          "Authorization": Shared.token!,
        },
      );
      var image = await http.MultipartFile.fromPath('img', imgFile.path);
      request.files.add(image);
      var response = await request.send();
      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 400) {
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
}
