class AppwriteConstants {
  static const String databaseId = '6432ee30a1f26d2ca801';
  static const String projectId = '6432e08f2c18882582c4';
  static const String endPoint = 'http://192.168.1.2:80/v1';
  static const String usersCollection = '6435ce179244a443e56b';
  static const String tweetsCollection = '6454b6bb82c79b496c8b';
  static const String imagesBucket = '6455cf7e589de0d1fdcc';
  static String imageUrl(String imageId) => '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';

}