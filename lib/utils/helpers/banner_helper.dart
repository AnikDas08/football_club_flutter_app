import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/services/api/api_service.dart';
import 'package:football_club/services/storage/storage_services.dart';

class BannerHelper {
  BannerHelper._();

  static final Map<String, String> _memoryCache = {};

  /// Synchronously retrieve cached banner URL (memory or local storage)
  static String? getCachedBanner(String section) {
    final key = section.toLowerCase();
    if (_memoryCache.containsKey(key) && _memoryCache[key]!.isNotEmpty) {
      return _memoryCache[key];
    }
    final cached = LocalStorage.getString('banner_$key');
    if (cached != null && cached.isNotEmpty) {
      _memoryCache[key] = cached;
      return cached;
    }
    return null;
  }

  static Future<String?> fetchBanner(String section) async {
    final key = section.toLowerCase();
    try {
      // 1. Direct hit to official endpoint: banners?section=$section
      var response = await ApiService.get(ApiEndPoint.banners(section));
      if (response.statusCode != 200 || response.data.isEmpty || response.data['data'] == null) {
        // 2. Fallback: banners/section?section=$section
        response = await ApiService.get('banners/section?section=$section');
      }
      if (response.statusCode != 200 || response.data.isEmpty || response.data['data'] == null) {
        // 3. Fallback: banners/$section
        response = await ApiService.get('banners/$section');
      }

      if (response.statusCode == 200 && response.data.isNotEmpty) {
        final url = parseBannerUrl(response.data);
        if (url != null && url.isNotEmpty) {
          _memoryCache[key] = url;
          await LocalStorage.setString('banner_$key', url);
          return url;
        }
      }
    } catch (_) {
      // Return cached banner on failure
    }
    return getCachedBanner(section);
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
