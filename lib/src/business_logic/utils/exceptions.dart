class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() {
    return message;
  }
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() {
    return message;
  }
}