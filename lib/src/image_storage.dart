import 'dart:async';
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

import 'file_utils.dart';

/// 网络图片缓存管理
@internal
class ImageStorage extends CacheManager with ImageCacheManager {
  ImageStorage(Config config) : super(config) {
    _getCacheDir(config);
  }

  Future<void> _getCacheDir(Config config) async {
    final cacheDir = (await FileUtils.getTempDir()) ?? '';
    if (cacheDir.isNotEmpty) {
      _cachePath = join(cacheDir, config.cacheKey);
    }
  }

  ///缓存文件家路径
  String _cachePath = '';

  String get cachePath => _cachePath;

  Directory get cacheDir => Directory(_cachePath);
}
