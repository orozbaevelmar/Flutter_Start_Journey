import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:start_journey/cleanArch/core/presentation/widgets/logo_loader.dart';
import 'package:start_journey/cleanArch/core/theme/app_color.dart';
import 'package:start_journey/cleanArch/core/utils/cache_manager.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final String? cacheKey;
  final Duration fadeInDuration;
  final bool useShimmer;
  final bool useResizedUrl;
  final int? resizeWidth;
  final int? resizeHeight;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.cacheKey,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.useShimmer = false,
    this.useResizedUrl = false,
    this.resizeWidth,
    this.resizeHeight,
  });

  String _resizedUrl(String url) {
    if (!useResizedUrl || resizeWidth == null || resizeHeight == null) {
      return url;
    }

    final uri = Uri.parse(url);
    final newQueryParams = Map<String, String>.from(uri.queryParameters)
      ..addAll({'w': '$resizeWidth', 'h': '$resizeHeight'});
    return uri.replace(queryParameters: newQueryParams).toString();
  }

  @override
  Widget build(BuildContext context) {
    final finalUrl = _resizedUrl(imageUrl);

    final image = CachedNetworkImage(
      imageUrl: finalUrl,
      width: width,
      height: height,
      fit: fit,
      cacheKey: cacheKey,
      cacheManager: CustomCacheManager.instance,
      fadeInDuration: fadeInDuration,
      placeholder: (context, url) {
        if (placeholder != null) return placeholder!;
        if (useShimmer) {
          return Shimmer.fromColors(
            baseColor: AppColor.greenPrimary,
            highlightColor: AppColor.greenPrimary,
            child: Container(
              width: width,
              height: height,
              color: AppColor.white,
            ),
          );
        }
        return const Center(child: RotatingLogoLoader(size: 100));
      },
      errorWidget: (context, url, error) =>
          errorWidget ??
          const Icon(
            Icons.broken_image,
            color: AppColor.black,
          ),
    );

    return borderRadius != null
        ? ClipRRect(borderRadius: borderRadius!, child: image)
        : image;
  }
}
