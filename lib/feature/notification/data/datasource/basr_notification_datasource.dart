
abstract class BaseNotificationDataSource {
  Future<List<String>> getPostTitles(String location);
   Future<List<String>> getLocation();
}
