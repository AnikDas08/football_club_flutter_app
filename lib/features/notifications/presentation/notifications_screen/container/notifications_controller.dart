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
  int page = 1;

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
      final list = await repository.getNotifications(page);
      notifications.assignAll(list);
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    }
  }

  /// Refresh manually
  @override
  Future<void> refresh() async {
    page = 1;
    await getNotifications();
  }
}
