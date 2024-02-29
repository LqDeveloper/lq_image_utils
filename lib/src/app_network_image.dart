import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'app_image_cache.dart';

typedef PlaceholderBuilder = Widget Function(
  BuildContext context,
  String? url,
);

typedef ProgressBuilder = Widget Function(
  BuildContext context,
  String? url,
  int? totalSize,
  int? downloaded,
  double? progress,
);

typedef ErrorBuilder = Widget Function(
  BuildContext context,
  String? url,
  dynamic error,
);

/// 网络图片加载Widget
class AppNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final Map<String, String>? httpHeaders;
  final PlaceholderBuilder? placeholder;
  final ProgressBuilder? progress;
  final ErrorBuilder? error;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment alignment;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  final Duration fadeOutDuration;
  final Curve fadeOutCurve;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.httpHeaders,
    this.placeholder,
    this.progress,
    this.error,
    this.width,
    this.height,
    this.fit,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeIn,
    this.alignment = Alignment.center,
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.fadeOutCurve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return error?.call(context, imageUrl, 'imageUrl 为空') ??
          SizedBox(
            width: width,
            height: height,
          );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      cacheManager: AppImageCache.instance.imageStorage,
      httpHeaders: httpHeaders,
      placeholder: placeholder,
      progressIndicatorBuilder: (context, url, info) {
        return progress?.call(
              context,
              url,
              info.totalSize,
              info.downloaded,
              info.progress,
            ) ??
            const SizedBox();
      },
      errorWidget: error,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      fadeOutDuration: fadeOutDuration,
      fadeOutCurve: fadeOutCurve,
      fadeInDuration: fadeInDuration,
      fadeInCurve: fadeInCurve,
    );
  }
}
