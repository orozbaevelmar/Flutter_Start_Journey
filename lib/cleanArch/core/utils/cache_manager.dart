import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static const key = 'optimizedImageCache';
  static final BaseCacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 1),
      maxNrOfCacheObjects: 100,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  );
}
