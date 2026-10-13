import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entity/notification_entity.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String time;
  final bool isUnread;
  final String? screen;
  final String? type;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.isUnread,
    this.screen,
    this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const NotificationModel(
        id: '',
        title: '',
        message: '',
        time: 'Just now',
        isUnread: false,
      );
    }

    bool unread = false;
    if (json.containsKey('read')) {
      unread = json['read'] == false;
    } else if (json.containsKey('isUnread')) {
      unread = json['isUnread'] == true;
    }

    final createdAt = json['createdAt'] ?? json['time'];
    final formattedTime = _formatTime(createdAt);

    return NotificationModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Notification',
      message: json['message']?.toString() ?? '',
      time: formattedTime,
      isUnread: unread,
      screen: json['screen']?.toString(),
      type: json['type']?.toString(),
    );
  }

  static String _formatTime(dynamic rawDate) {
    if (rawDate == null || rawDate.toString().trim().isEmpty) {
      return 'Just now';
    }

    try {
      final dateTime = DateTime.tryParse(rawDate.toString())?.toLocal();
      if (dateTime != null) {
        final now = DateTime.now();
        final diff = now.difference(dateTime);

        if (diff.isNegative || diff.inSeconds < 60) {
          return 'Just now';
        } else if (diff.inMinutes < 60) {
          return '${diff.inMinutes}m ago';
        } else if (diff.inHours < 24) {
          return '${diff.inHours}h ago';
        } else if (diff.inDays < 7) {
          return '${diff.inDays}d ago';
        } else if (diff.inDays < 30) {
          final weeks = (diff.inDays / 7).floor();
          return '${weeks}w ago';
        } else {
          return DateFormat('dd MMM yyyy').format(dateTime);
        }
      }
    } catch (_) {}

    return rawDate.toString();
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      message: message,
      time: time,
      isUnread: isUnread,
      screen: screen,
      type: type,
      icon: _getIcon(),
      iconColor: _getIconColor(),
    );
  }

  IconData _getIcon() {
    final lowerTitle = title.toLowerCase();
    final lowerScreen = (screen ?? '').toLowerCase();

    if (lowerScreen.contains('development') ||
        lowerTitle.contains('note') ||
        lowerTitle.contains('feedback') ||
        lowerTitle.contains('session')) {
      return Icons.chat_bubble_outline_rounded;
    } else if (lowerTitle.contains('trophy') ||
        lowerTitle.contains('achievement') ||
        lowerTitle.contains('award') ||
        lowerTitle.contains('match')) {
      return Icons.emoji_events_outlined;
    } else if (lowerTitle.contains('training') ||
        lowerTitle.contains('practice')) {
      return Icons.show_chart_rounded;
    } else if (lowerTitle.contains('target') ||
        lowerTitle.contains('goal')) {
      return Icons.track_changes;
    } else if (lowerTitle.contains('assessment') ||
        lowerTitle.contains('report')) {
      return Icons.bar_chart_rounded;
    }

    return isUnread
        ? Icons.chat_bubble_outline_rounded
        : Icons.notifications_none_outlined;
  }

  Color _getIconColor() {
    final lowerTitle = title.toLowerCase();
    final lowerScreen = (screen ?? '').toLowerCase();

    if (lowerScreen.contains('development') ||
        lowerTitle.contains('note') ||
        lowerTitle.contains('feedback') ||
        lowerTitle.contains('session')) {
      return const Color(0xFF3B82F6);
    } else if (lowerTitle.contains('trophy') ||
        lowerTitle.contains('achievement') ||
        lowerTitle.contains('award') ||
        lowerTitle.contains('match')) {
      return const Color(0xFFF59E0B);
    } else if (lowerTitle.contains('training') ||
        lowerTitle.contains('practice')) {
      return const Color(0xFF10B981);
    } else if (lowerTitle.contains('target') ||
        lowerTitle.contains('goal')) {
      return const Color(0xFFA855F7);
    } else if (lowerTitle.contains('assessment') ||
        lowerTitle.contains('report')) {
      return const Color(0xFFF97316);
    }

    return isUnread ? const Color(0xFF3B82F6) : const Color(0xFF8E9BAE);
  }
}
