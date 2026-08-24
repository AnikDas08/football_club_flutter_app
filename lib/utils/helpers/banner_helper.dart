import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/services/api/api_service.dart';

class BannerHelper {
  BannerHelper._();

  static Future<String?> fetchBanner(String section) async {
    try {
      // 1. Try banners/section?section=$section
      var response = await ApiService.get('banners/section?section=$section');
      if (response.statusCode != 200 || response.data == null || response.data['data'] == null) {
        // 2. Try banners?section=$section
        response = await ApiService.get(ApiEndPoint.banners(section));
      }
      if (response.statusCode != 200 || response.data == null || response.data['data'] == null) {
        // 3. Try banners/$section
        response = await ApiService.get('banners/$section');
      }

      if (response.statusCode == 200 && response.data != null) {
        return parseBannerUrl(response.data);
      }
    } catch (_) {
      // Return null on failure to fall back to static image
    }
    return null;
  }

  static String? parseBannerUrl(dynamic data) {
    if (data == null) return null;
    Map<String, dynamic>? item;

    if (data is Map<String, dynamic>) {
      final raw = data['data'];
      if (raw is Map<String, dynamic>) {
        item = raw;
      } else if (raw is List && raw.isNotEmpty) {
        item = raw.first as Map<String, dynamic>;
      } else {
        item = data;
      }
    } else if (data is List && data.isNotEmpty) {
      item = data.first as Map<String, dynamic>;
    }

    final String? img =
        item?['image'] ?? item?['bannerImage'] ?? item?['imageUrl'];
    if (img != null && img.isNotEmpty) {
      if (img.startsWith('http')) return img;
      return '${ApiEndPoint.imageUrl}$img';
    }
    return null;
  }
}
