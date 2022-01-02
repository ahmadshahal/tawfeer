import 'package:tawfeer/src/business_logic/models/user.dart';
import 'package:tawfeer/src/business_logic/services/api_services/user_api.dart';

class UserRepository {
  final UserAPI _userAPI = UserAPI();

  Future<User> fetchUser({required int id}) async {
    // return await _userAPI.showUser(id);

    return await Future.delayed(const Duration(seconds: 3), () {
      return User(
        id: id,
        fullName: "Ahmad Al-Shahal",
        email: "ahmad.alshahal2@gmail.com",
        phoneNumber: '+963951737433',
      );
    });

    // throw TawfeerException('Failed');
  }

  Future<User> profile() async {
    return await Future.delayed(const Duration(seconds: 3), () {
      return User(
        id: 1,
        fullName: "Ahmad Al-Shahal",
        email: "ahmad.alshahal2@gmail.com",
        phoneNumber: '+963951737433',
        imgUrl:
            'https://scontent.flca1-1.fna.fbcdn.net/v/t1.6435-9/66344627_1304933179673247_145168880992518144_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=pMsJBMCP6HUAX83U1ar&_nc_ht=scontent.flca1-1.fna&oh=00_AT9tlK9NRiwDpV4Xu2BQ_Dk7-UO5X70iC6zURlPfykZGqw&oe=61F7C3DA',
      );
    });
    // throw TawfeerException('Failed');
    // return await _userAPI.profile();
  }

  Future<String> login(
      {required String email, required String password}) async {
    // return await _userAPI.login(email, password);
    return await Future.delayed(const Duration(seconds: 3), () => "=========");
    // throw TawfeerException('Failed');
  }

  Future<void> logout() async {
    return await Future.delayed(const Duration(seconds: 3));
    // throw TawfeerException('Failed');
  }

  Future<String> register({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    // return await _userAPI.register(fullName, email, password, phoneNumber);
    return await Future.delayed(const Duration(seconds: 3), () => "=========");
    // throw TawfeerException('Failed');
  }

  static Future<void> validateToken(String token) async {
    // return await UserAPI().validateToken(token);
    return await Future.delayed(const Duration(seconds: 1));
  }
}
