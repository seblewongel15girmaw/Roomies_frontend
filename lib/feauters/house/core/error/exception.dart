class ServerException implements Exception{
  String errorMessage;

  ServerException({required this.errorMessage});
}

class CacheException implements Exception{}