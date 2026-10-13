import 'package:flutter/foundation.dart';
import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/services/api/api_service.dart';
import 'package:get/get.dart';
import '../model/notification_model.dart';
import '../../domain/entity/notification_entity.dart';
import '../../presentation/notifications_screen/controller/notifications_controller.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationEntity>> getNotifications(int page);
  Future<bool> markAsRead(String id);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  @override
  Future<bool> markAsRead(String id) async {
    try {
      final response = await ApiService.patch(
        ApiEndPoint.readNotification(id),
      );
      return response.isSuccess;
    } catch (e) {
      debugPrint("Error marking notification as read: $e");
      return false;
    }
  }

  @override
  Future<List<NotificationEntity>> getNotifications(int page) async {
    try {
      final response = await ApiService.get(
        '${ApiEndPoint.notifications}?page=$page&limit=20',
      );
      if (response.isSuccess) {
        final data = response.data['data'];
        List<dynamic> resultList = [];
        if (data is Map<String, dynamic>) {
          if (data['unreadCount'] is num) {
            final count = (data['unreadCount'] as num).toInt();
            if (Get.isRegistered<NotificationsController>()) {
              Get.find<NotificationsController>().unreadCount.value = count;
            }
          }
          if (data['result'] is List) {
            resultList = data['result'] as List<dynamic>;
          }
        } else if (data is List) {
          resultList = data;
        }

        return resultList
            .map((item) => NotificationModel.fromJson(item as Map<String, dynamic>).toEntity())
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint("Error fetching notifications: $e");
      return [];
    }
  }
}
