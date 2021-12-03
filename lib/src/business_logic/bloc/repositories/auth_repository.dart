class AuthRepository {
  Future<void> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 3));
    // throw Exception('Failed');
  }

  Future<bool> isEmailValid({required String email}) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> isPasswordValid({required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}