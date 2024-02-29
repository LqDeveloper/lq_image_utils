import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

/// 网络Svg图片加载
class SvgNetworkImage extends StatelessWidget {
  final String? url;
  final Map<String, String>? headers;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final WidgetBuilder? placeholderBuilder;
  final Clip clipBehavior;
  final SvgTheme theme;
  final ui.ColorFilter? colorFilter;

  const SvgNetworkImage({
    super.key,
    required this.url,
    this.headers,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.placeholderBuilder,
    this.clipBehavior = Clip.hardEdge,
    this.theme = const SvgTheme(),
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return placeholderBuilder?.call(context) ??
          SizedBox(
            width: width,
            height: height,
          );
    }
    return SvgPicture.network(
      url!,
      headers: headers,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      placeholderBuilder: placeholderBuilder,
      clipBehavior: clipBehavior,
      theme: theme,
      colorFilter: colorFilter,
    );
  }
}
