import 'package:flutter/material.dart';
import '../../domain/entity/notification_entity.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String time;
  final bool isUnread;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.isUnread,
  });

  factory NotificationModel.fromJson(Map<String, dynamic>? json) {
    return NotificationModel(
      id: json?['_id'] ?? json?['id'] ?? '',
      title: json?['title'] ?? 'Notification',
      message: json?['message'] ?? '',
      time: json?['time'] ?? 'Just now',
      isUnread: json?['isUnread'] ?? false,
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      message: message,
      time: time,
      isUnread: isUnread,
      icon: isUnread
          ? Icons.chat_bubble_outline_rounded
          : Icons.notifications_none_outlined,
      iconColor: isUnread ? const Color(0xFF3B82F6) : const Color(0xFF8E9BAE),
    );
  }
}
