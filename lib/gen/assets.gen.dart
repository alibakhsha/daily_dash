/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/add.png
  AssetGenImage get add => const AssetGenImage('assets/images/add.png');

  /// File path: assets/images/arrow_left.png
  AssetGenImage get arrowLeft =>
      const AssetGenImage('assets/images/arrow_left.png');

  /// File path: assets/images/calendar.png
  AssetGenImage get calendar =>
      const AssetGenImage('assets/images/calendar.png');

  /// File path: assets/images/check_task.png
  AssetGenImage get checkTask =>
      const AssetGenImage('assets/images/check_task.png');

  /// File path: assets/images/daily_dash_logo.jpg
  AssetGenImage get dailyDashLogo =>
      const AssetGenImage('assets/images/daily_dash_logo.jpg');

  /// File path: assets/images/delete.png
  AssetGenImage get delete => const AssetGenImage('assets/images/delete.png');

  /// File path: assets/images/first_page_image.png
  AssetGenImage get firstPageImage =>
      const AssetGenImage('assets/images/first_page_image.png');

  /// File path: assets/images/fitness.png
  AssetGenImage get fitness => const AssetGenImage('assets/images/fitness.png');

  /// File path: assets/images/other.png
  AssetGenImage get other => const AssetGenImage('assets/images/other.png');

  /// File path: assets/images/study.png
  AssetGenImage get study => const AssetGenImage('assets/images/study.png');

  /// File path: assets/images/tabler_edit.png
  AssetGenImage get tablerEdit =>
      const AssetGenImage('assets/images/tabler_edit.png');

  /// File path: assets/images/work.png
  AssetGenImage get work => const AssetGenImage('assets/images/work.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        add,
        arrowLeft,
        calendar,
        checkTask,
        dailyDashLogo,
        delete,
        firstPageImage,
        fitness,
        other,
        study,
        tablerEdit,
        work
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
