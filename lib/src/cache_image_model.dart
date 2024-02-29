/// 缓存图片信息
class CacheImageModel {
  final int? id;

  final String url;

  final String fileName;

  final String path;

  final DateTime validTill;

  final String? eTag;

  final int? length;

  final DateTime? touched;

  CacheImageModel({
    required this.url,
    required this.fileName,
    required this.path,
    required this.validTill,
    this.eTag,
    this.id,
    this.length,
    this.touched,
  });
}
