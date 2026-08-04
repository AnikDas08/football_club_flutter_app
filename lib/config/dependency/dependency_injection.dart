import 'package:get/get.dart';

import '../../features/auth/presentation/change_password/container/change_password_controller.dart';
import '../../features/auth/presentation/forgot_password/container/forget_password_controller.dart';
import '../../features/auth/presentation/sign_in/container/sign_in_controller.dart';
import '../../features/auth/presentation/sign_up/container/sign_up_controller.dart';
import '../../features/message/presentation/controller/chat_controller.dart';
import '../../features/message/presentation/controller/message_controller.dart';
import '../../features/notifications/presentation/notifications_screen/container/notifications_controller.dart';
import '../../features/profile/presentation/profile_screen/container/profile_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => ForgetPasswordController(), fenix: true);
    Get.lazyPut(() => ChangePasswordController(), fenix: true);
    Get.lazyPut(() => NotificationsController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => MessageController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}
