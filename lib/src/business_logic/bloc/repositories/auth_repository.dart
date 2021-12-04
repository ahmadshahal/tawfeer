class AuthRepository {
  Future<void> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 3));
    // throw Exception('Failed');
  }
}