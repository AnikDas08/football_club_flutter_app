import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/api/api_end_point.dart';
import '../../utils/constants/app_images.dart';
import '../../utils/log/error_log.dart';

class CommonImage extends StatelessWidget {
  final String imageSrc;
  final String defaultImage;
  final IconData? fallbackIcon;
  final bool showIconFallback;
  final Color? imageColor;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? size;

  final BoxFit fill;

  const CommonImage({
    required this.imageSrc,
    this.defaultImage = AppImages.profile_image,
    this.fallbackIcon = Icons.person_rounded,
    this.showIconFallback = true,
    this.imageColor,
    this.height,
    this.borderRadius = 0,
    this.width,
    this.size,
    this.fill = BoxFit.contain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cleanSrc = imageSrc.trim();

    if (cleanSrc.isEmpty ||
        cleanSrc == 'null' ||
        cleanSrc == 'undefined' ||
        cleanSrc == AppImages.profile_image) {
      return _buildErrorWidget();
    } else if (cleanSrc.contains('assets/icons') || cleanSrc.endsWith('.svg')) {
      return _buildSvgImage();
    } else if (cleanSrc.startsWith('assets/')) {
      return _buildPngImage();
    }

    // Check if it is a real local device file (e.g., image picked from gallery/camera)
    try {
      if (cleanSrc.startsWith('/var/') ||
          cleanSrc.startsWith('/Users/') ||
          cleanSrc.startsWith('/storage/') ||
          cleanSrc.startsWith('/data/user/')) {
        if (File(cleanSrc).existsSync()) {
          return _buildFileImage();
        }
      }
    } catch (_) {}

    // Otherwise, treat all API paths as network image URLs
    return _buildNetworkImage();
  }

  Widget _buildErrorWidget() {
    final double? w = size?.sp ?? width;
    final double? h = size?.sp ?? height;
    final double iconDimension = (w != null && h != null && w > 0 && h > 0)
        ? (w < h ? w : h) * 0.52
        : (size != null ? size! * 0.52 : 24.sp);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: const Color(0xFF111A2E),
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Icon(
          fallbackIcon ?? Icons.person_rounded,
          color: const Color(0xFF8E9BAE),
          size: iconDimension,
        ),
      ),
    );
  }

  Widget _buildPlaceholderWidget(double? w, double? h) {
    // Show clean profile icon placeholder immediately (no stuck spinning loader)
    return _buildErrorWidget();
  }

  Widget _buildFileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: Image.file(
        File(imageSrc),
        fit: fill,
        height: size?.sp ?? height,
        width: size?.sp ?? width,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      ),
    );
  }

  Widget _buildNetworkImage() {
    final String fullUrl = ApiEndPoint.getFullImageUrl(imageSrc);

    final double? w = size?.sp ?? width;
    final double? h = size?.sp ?? height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: CachedNetworkImage(
        height: h,
        width: w,
        imageUrl: fullUrl,
        fit: fill,
        fadeInDuration: const Duration(milliseconds: 200),
        fadeOutDuration: const Duration(milliseconds: 100),
        placeholder: (context, url) => _buildPlaceholderWidget(w, h),
        errorWidget: (context, url, error) {
          debugPrint('❌ CommonImage error loading ($fullUrl): $error');
          errorLog(error, source: 'Common Image ($fullUrl)');
          return _buildErrorWidget();
        },
      ),
    );
  }

  Widget _buildSvgImage() {
    return SvgPicture.asset(
      imageSrc,
      color: imageColor,
      height: size?.sp ?? height?.h,
      width: size?.sp ?? width?.w,
      fit: fill,
    );
  }

  Widget _buildPngImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        imageSrc,
        color: imageColor,
        height: size?.sp ?? height?.h,
        width: size?.sp ?? width?.w,
        fit: fill,
        errorBuilder: (context, error, stackTrace) {
          errorLog(error, source: 'Common Image');
          return _buildErrorWidget();
        },
      ),
    );
  }
}
