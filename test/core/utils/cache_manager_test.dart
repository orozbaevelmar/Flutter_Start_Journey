import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:start_journey/cleanArch/core/utils/cache_manager.dart';

void main() {
  group('CustomCacheManager', () {
    test('should have correct cache key', () {
      expect(CustomCacheManager.key, equals('optimizedImageCache'));
    });

    test('should have correct cache configuration', () {
      final cacheManager = CustomCacheManager.instance as CacheManager;
      expect(cacheManager.config.cacheKey, equals('optimizedImageCache'));
      expect(cacheManager.config.stalePeriod, equals(const Duration(days: 1)));
      expect(cacheManager.config.maxNrOfCacheObjects, equals(100));
    });

    test('should be a singleton instance', () {
      final instance1 = CustomCacheManager.instance;
      final instance2 = CustomCacheManager.instance;
      expect(identical(instance1, instance2), isTrue);
    });
  });
}
