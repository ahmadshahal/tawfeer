import 'package:tawfeer/src/business_logic/models/user.dart';
import 'package:tawfeer/src/business_logic/services/api_services/user_api.dart';

class UserRepository {

  final UserAPI _userAPI = UserAPI();

  Future<User> fetchUser({required int id}) async {
    return await Future.delayed(const Duration(seconds: 3), () {
      return User(
        id: id,
        fullName: "Ahmad Al-Shahal",
        email: "ahmad.alshahal2@gmail.com",
        phoneNumber: '+963951737433',
      );
    });
    // throw Exception('Failed');
  }

  Future<User> profile() async {
    return await Future.delayed(const Duration(seconds: 3), () {
      return User(
        id: 1,
        fullName: "Ahmad Al-Shahal",
        email: "ahmad.alshahal2@gmail.com",
        phoneNumber: '+963951737433',
      );
    });
    // throw Exception('Failed');
    // return await _userAPI.profile();
  }

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
