import 'package:tawfeer/src/business_logic/services/api_services/user_api.dart';

class AuthRepository {

  final UserAPI _userAPI = UserAPI();

  Future<String> login({required String email, required String password}) async {
    // return await _userAPI.login(email, password);
    return await Future.delayed(const Duration(seconds: 3), () => "=========");
    // throw Exception('Failed');
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    // throw Exception('Failed');
  }
}
