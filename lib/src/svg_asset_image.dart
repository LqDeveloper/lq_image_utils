import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

/// asset中的Svg图片加载
class SvgAssetImage extends StatelessWidget {
  final String name;
  final AssetBundle? bundle;
  final String? package;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final WidgetBuilder? placeholderBuilder;
  final Clip clipBehavior;
  final SvgTheme? theme;
  final ui.ColorFilter? colorFilter;

  const SvgAssetImage({
    super.key,
    required this.name,
    this.bundle,
    this.package,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.placeholderBuilder,
    this.clipBehavior = Clip.hardEdge,
    this.theme,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    if (name.isEmpty) {
      return placeholderBuilder?.call(context) ??
          SizedBox(
            width: width,
            height: height,
          );
    }
    return SvgPicture.asset(
      name,
      bundle: bundle,
      package: package,
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
