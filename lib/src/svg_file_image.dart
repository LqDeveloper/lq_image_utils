import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

/// 本地Svg图片加载
class SvgFileImage extends StatelessWidget {
  final File? file;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final WidgetBuilder? placeholderBuilder;
  final Clip clipBehavior;
  final SvgTheme theme;
  final ui.ColorFilter? colorFilter;

  const SvgFileImage({
    super.key,
    required this.file,
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
    if (file == null) {
      return placeholderBuilder?.call(context) ??
          SizedBox(
            width: width,
            height: height,
          );
    }
    return SvgPicture.file(
      file!,
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
