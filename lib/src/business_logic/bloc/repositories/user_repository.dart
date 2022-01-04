import 'package:tawfeer/src/business_logic/models/user.dart';
import 'package:tawfeer/src/business_logic/services/api_services/user_api.dart';

class UserRepository {
  final UserAPI _userAPI = UserAPI();

  Future<User> fetchUser({required int id}) async {
    return await _userAPI.showUser(id);
  }

  Future<User> profile() async {
    return await _userAPI.profile();
  }

  Future<String> login(
      {required String email, required String password}) async {
    return await _userAPI.login(email, password);
  }

  Future<void> logout() async {
    return await _userAPI.logout();
  }

  Future<String> register({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    return await _userAPI.register(fullName, email, password, phoneNumber);
  }

  Future<void> validateToken(String token) async {
    return await _userAPI.validateToken(token);
  }
}
