

class ServerException implements Exception {
  final String errorMessage;

  const ServerException({required this.errorMessage});
}

class AuthException  implements Exception {
  final String errorMessage;

  const AuthException({required this.errorMessage});
}
class FirestoreException implements Exception {
  final String errorMessage;

  const FirestoreException({required this.errorMessage});
}
