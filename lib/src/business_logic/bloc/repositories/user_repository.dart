import 'package:tawfeer/src/business_logic/models/user.dart';

class UserRepository {
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
}
