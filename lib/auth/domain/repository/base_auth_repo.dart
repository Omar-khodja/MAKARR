abstract class BaseUserRepo {
  Future<void> createUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String birthDate,
    required String id,
    required String phoneNumber,
  });
  Future<void> login(String email, String password);
  Future<void> singOut();
}
