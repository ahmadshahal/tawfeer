import 'package:tawfeer/src/business_logic/models/user.dart';

class UserRepository {
  Future<User> fetchUser({required int id}) async {
    return await Future.delayed(const Duration(seconds: 3), () {
      return User(
        id: id,
        fullName: "Ahmad Al-Shahal",
        email: "ahmad.alshahal2@gmail.com",
        phoneNumber: '+963951737433',
        imgUrl:
            'https://scontent.flca1-1.fna.fbcdn.net/v/t1.6435-9/66344627_1304933179673247_145168880992518144_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=orZ-ALdojNoAX_I8gpt&_nc_ht=scontent.flca1-1.fna&oh=3e36c5d41417eb3f54b7e31c7e8eb1cc&oe=61D42B5A',
      );
    });
    // throw Exception('Failed');
  }
}
