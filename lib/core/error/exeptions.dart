

class ServerException implements Exception {
  final String errorMessage;

  const ServerException({required this.errorMessage});
}

class AuthException  implements Exception {
  final String message;

  const AuthException({required this.message});
}
