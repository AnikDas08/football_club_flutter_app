import 'package:flutter/material.dart';

class NotificationEntity {
  final String id;
  final String title;
  final String message;
  final String time;
  final bool isUnread;
  final IconData icon;
  final Color? iconColor;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.isUnread,
    this.icon = Icons.notifications_none_outlined,
    this.iconColor,
  });
}
