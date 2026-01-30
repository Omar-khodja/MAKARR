

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class PhotoViewCacheManager extends CacheManager {
  static final PhotoViewCacheManager _instance =
      PhotoViewCacheManager._internal();

  factory PhotoViewCacheManager() => _instance;

  PhotoViewCacheManager._internal()
    : super(
        Config(
          'photoViewCache',
          stalePeriod: const Duration(minutes: 15),
          maxNrOfCacheObjects: 100,
        ),
      );
}
