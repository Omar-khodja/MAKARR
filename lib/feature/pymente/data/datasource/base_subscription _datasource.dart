
abstract class BasesubscriptionDatasource {
  Future<String> subscription(String planmm, String userId);
  Future<String> checksubscription(String userId);
}
