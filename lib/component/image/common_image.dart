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
  final Color? imageColor;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? size;

  final BoxFit fill;

  const CommonImage({
    required this.imageSrc,
    this.imageColor,
    this.height,
    this.borderRadius = 0,
    this.width,
    this.size,
    this.fill = BoxFit.contain,
    this.defaultImage = AppImages.profile_image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cleanSrc = imageSrc.trim();

    if (cleanSrc.isEmpty) {
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
    return Image.asset(
      defaultImage,
      fit: fill,
      height: size?.sp ?? height?.h,
      width: size?.sp ?? width?.w,
    );
  }

  Widget _buildFileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.file(
        File(imageSrc),
        fit: fill,
        height: size?.sp ?? height?.h,
        width: size?.sp ?? width?.w,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      ),
    );
  }

  Widget _buildNetworkImage() {
    final String cleanSrc = imageSrc.trim();
    final String fullUrl = cleanSrc.startsWith('http')
        ? cleanSrc
        : (cleanSrc.startsWith('/')
            ? '${ApiEndPoint.imageUrl}$cleanSrc'
            : '${ApiEndPoint.imageUrl}/$cleanSrc');

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        height: size?.sp ?? height?.h,
        width: size?.sp ?? width?.w,
        imageUrl: fullUrl,
        fit: fill,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(image: imageProvider, fit: fill),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            Center(
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
            strokeWidth: 2,
          ),
        ),
        errorWidget: (context, url, error) {
          errorLog(error, source: 'Common Image');
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
