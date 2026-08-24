import 'package:flutter/material.dart';
import 'package:football_club/config/api/api_end_point.dart';
import 'package:football_club/services/api/api_service.dart';
import '../../domain/entity/notification_entity.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationEntity>> getNotifications(int page);
  Future<bool> markAsRead(String id);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  @override
  Future<bool> markAsRead(String id) async {
    try {
      final response = await ApiService.patch(
        '${ApiEndPoint.notifications}/$id',
        body: {'isUnread': false},
      );
      return response.isSuccess;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<NotificationEntity>> getNotifications(int page) async {
    return const [
      NotificationEntity(
        id: "1",
        title: "New Coach Note",
        message: "Coach Davies added feedback from your Tuesday session.",
        time: "2h ago",
        isUnread: true,
        icon: Icons.chat_bubble_outline_rounded,
        iconColor: Color(0xFF3B82F6),
      ),
      NotificationEntity(
        id: "2",
        title: "Achievement Unlocked! 🏆",
        message: "You earned Player of the Match vs Riverside FC.",
        time: "1d ago",
        isUnread: true,
        icon: Icons.emoji_events_outlined,
        iconColor: Color(0xFFF59E0B),
      ),
      NotificationEntity(
        id: "3",
        title: "Upcoming Training",
        message: "Training session tomorrow at 6:00 PM — TFP Academy.",
        time: "2d ago",
        isUnread: false,
        icon: Icons.show_chart_rounded,
        iconColor: Color(0xFF10B981),
      ),
      NotificationEntity(
        id: "4",
        title: "Target Updated",
        message: "Coach updated your Pressing Intensity target to 50%.",
        time: "3d ago",
        isUnread: false,
        icon: Icons.track_changes,
        iconColor: Color(0xFFA855F7),
      ),
      NotificationEntity(
        id: "5",
        title: "Assessment Due",
        message: "Your monthly assessment is due in 3 days.",
        time: "4d ago",
        isUnread: false,
        icon: Icons.bar_chart_rounded,
        iconColor: Color(0xFFF97316),
      ),
    ];
  }
}
