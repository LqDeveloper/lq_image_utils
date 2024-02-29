import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'cache_image_model.dart';
import 'file_utils.dart';
import 'image_storage.dart';

/// App图片缓存管理
class AppImageCache {
  static final AppImageCache instance = AppImageCache._();

  factory AppImageCache() => instance;

  AppImageCache._() {
    _initImageCache();
  }

  ///缓存文件夹名称
  static const String _cacheDirName = 'app_cache_image';

  Config _config = Config(_cacheDirName);

  ImageStorage? _imageStorage;

  ImageStorage get imageStorage {
    return _imageStorage ??= ImageStorage(_config);
  }

  late Future<CacheInfoRepository> _cacheInfoRepository;

  ///初始化缓存文件路径
  void _initImageCache() {
    _config = Config(_cacheDirName);
    _imageStorage = ImageStorage(_config);
    _cacheInfoRepository = _config.repo.open().then((value) => _config.repo);
  }

  ///获取图片缓存大小
  Future<int> getSize() async {
    final provider = await _cacheInfoRepository;
    final cacheList = await provider.getAllObjects();
    int size = 0;
    for (final item in cacheList) {
      size += (item.length ?? 0);
    }
    return size;
  }

  ///获取缓存大小 B，KB，MB，GB
  Future<String> getSizeStr() async {
    final size = await getSize();
    return FileUtils.formatSize(size);
  }

  Future<List<CacheImageModel>> getAllCache() async {
    final provider = await _cacheInfoRepository;
    final list = await provider.getAllObjects();
    return list
        .map((e) => CacheImageModel(
              url: e.url,
              fileName: e.relativePath,
              path: '${imageStorage.cachePath}/${e.relativePath}',
              validTill: e.validTill,
              eTag: e.eTag,
              id: e.id,
              length: e.length,
              touched: e.touched,
            ))
        .toList();
  }

  ///获取缓存文件信息
  Future<FileInfo?> getFileFromCache(String key,
          {bool ignoreMemCache = false}) =>
      imageStorage.getFileFromCache(key, ignoreMemCache: ignoreMemCache);

  ///获取缓存文件信息
  Future<FileInfo?> getFileFromMemory(String key) =>
      imageStorage.getFileFromMemory(key);

  ///移除指定URL缓存
  Future<void> removeFile(String key) async {
    final provider = await _cacheInfoRepository;
    final cacheObj = await provider.get(key);
    final path = cacheObj?.relativePath ?? '';
    final cachePath = imageStorage.cachePath;
    if (path.isNotEmpty && cachePath.isNotEmpty) {
      final fullPath = "$cachePath/$path";
      await FileUtils.deleteFile(fullPath);
    }
    await imageStorage.removeFile(key);
  }

  ///清空图片缓存
  Future<void> clear() async {
    await imageStorage.emptyCache();
    await FileUtils.deleteDir(imageStorage.cacheDir);
  }
}
