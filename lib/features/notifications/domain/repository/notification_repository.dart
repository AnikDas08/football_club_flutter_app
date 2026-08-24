import '../entity/notification_entity.dart';

abstract class NotificationRepository {
  Future<List<NotificationEntity>> getNotifications(int page);
  Future<bool> markAsRead(String id);
}
