import 'package:football_club/features/notifications/data/repository_impl/notification_repository_impl.dart';
import 'package:football_club/features/notifications/domain/entity/notification_entity.dart';
import 'package:football_club/features/notifications/domain/repository/notification_repository.dart';
import 'package:football_club/utils/app_snackbar.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final NotificationRepository repository;

  NotificationsController({NotificationRepository? repository})
      : repository = repository ?? NotificationRepositoryImpl();

  /// Reactive notification list - no update() needed
  final notifications = <NotificationEntity>[].obs;
  final isLoading = false.obs;
  final unreadCount = 0.obs;
  int page = 1;

  bool get hasUnread =>
      unreadCount.value > 0 || notifications.any((e) => e.isUnread);

  int get totalUnreadCount {
    if (unreadCount.value > 0) return unreadCount.value;
    return notifications.where((e) => e.isUnread).length;
  }

  /// Get instance
  static NotificationsController get instance =>
      Get.find<NotificationsController>();

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  /// Fetch notifications from RemoteDataSource
  Future<void> getNotifications() async {
    try {
      isLoading.value = true;
      final list = await repository.getNotifications(page);
      notifications.assignAll(list);
      final localCount = notifications.where((e) => e.isUnread).length;
      if (unreadCount.value == 0 && localCount > 0) {
        unreadCount.value = localCount;
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh manually
  @override
  Future<void> refresh() async {
    page = 1;
    await getNotifications();
  }

  /// Mark notification as read when clicked
  Future<void> markAsRead(String id) async {
    if (id.isEmpty) return;
    final index = notifications.indexWhere((element) => element.id == id);
    if (index != -1 && notifications[index].isUnread) {
      final old = notifications[index];
      notifications[index] = NotificationEntity(
        id: old.id,
        title: old.title,
        message: old.message,
        time: old.time,
        isUnread: false,
        icon: old.icon,
        iconColor: old.iconColor,
        screen: old.screen,
        type: old.type,
      );
      notifications.refresh();
      if (unreadCount.value > 0) {
        unreadCount.value--;
      }
      await repository.markAsRead(id);
    }
  }
}
