class TawfeerException implements Exception {
  final String message;
  TawfeerException(this.message);
  @override
  String toString() {
    return message;
  }
}

class NetworkException extends TawfeerException {
  NetworkException(String message) : super(message);
}

class ServerException extends TawfeerException {
  ServerException(String message) : super(message);
}

class UnknownException extends TawfeerException {
  UnknownException(String message) : super(message);
}