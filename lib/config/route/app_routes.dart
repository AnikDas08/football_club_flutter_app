import 'package:football_club/features/auth/presentation/change_password/screen/change_password_screen.dart';
import 'package:football_club/features/auth/presentation/forgot_password/screen/create_password.dart';
import 'package:football_club/features/auth/presentation/forgot_password/screen/forgot_password.dart';
import 'package:football_club/features/auth/presentation/forgot_password/screen/verify_screen.dart';
import 'package:football_club/features/auth/presentation/sign_in/screen/sign_in_screen.dart';
import 'package:football_club/features/auth/presentation/sign_up/screen/sign_up_screen.dart';
import 'package:football_club/features/auth/presentation/sign_up/screen/verify_user.dart';
import 'package:football_club/features/home/presentation/coach_feedback/screen/all_coach_feedback_screen.dart';
import 'package:football_club/features/home/presentation/home_nav/screen/home_nav_screen.dart';
import 'package:football_club/features/message/presentation/screen/chat_screen.dart';
import 'package:football_club/features/message/presentation/screen/message_screen.dart';
import 'package:football_club/features/notifications/presentation/screen/notifications_screen.dart';
import 'package:football_club/features/onboarding/onboarding_screen/onboarding_screen.dart';
import 'package:football_club/features/profile/presentation/screen/about_tfp_screen.dart';
import 'package:football_club/features/profile/presentation/screen/edit_profile.dart';
import 'package:football_club/features/profile/presentation/screen/help_support_screen.dart';
import 'package:football_club/features/profile/presentation/screen/privacy_policy_screen.dart';
import 'package:football_club/features/profile/presentation/screen/profile_screen.dart';
import 'package:football_club/features/profile/presentation/screen/terms_and_conditions_screen.dart';
import 'package:football_club/features/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String test = '/test_screen.dart';
  static const String splash = '/';
  static const String onboarding = '/onboarding_screen.dart';
  static const String signUp = '/sign_up_screen.dart';
  static const String verifyUser = '/verify_user.dart';
  static const String signIn = '/sign_in_screen.dart';
  static const String forgotPassword = '/forgot_password.dart';
  static const String verifyEmail = '/verify_screen.dart';
  static const String createPassword = '/create_password.dart';
  static const String changePassword = '/change_password_screen.dart';
  static const String notifications = '/notifications_screen.dart';
  static const String chat = '/chat_screen.dart';
  static const String message = '/message_screen.dart';
  static const String profile = '/profile_screen.dart';
  static const String editProfile = '/edit_profile.dart';
  static const String privacyPolicy = '/privacy_policy_screen.dart';
  static const String termsOfServices = '/terms_of_services_screen.dart';
  static const String setting = '/setting_screen.dart';
  static const String home = '/home_nav_screen.dart';
  static const String aboutTfp = '/about_tfp_screen.dart';
  static const String helpSupport = '/help_support_screen.dart';
  static const String allCoachFeedback = '/all_coach_feedback_screen.dart';

  static List<GetPage<String>> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: verifyUser, page: () => const VerifyUser()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: verifyEmail, page: () => VerifyScreen()),
    GetPage(name: createPassword, page: () => CreatePassword()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),
    GetPage(name: notifications, page: () => const NotificationScreen()),
    GetPage(name: chat, page: () => const ChatListScreen()),
    GetPage(name: message, page: () => const MessageScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: editProfile, page: () => EditProfile()),
    GetPage(name: home, page: () => HomeNavScreen()),
    GetPage(name: aboutTfp, page: () => const AboutTfpScreen()),
    GetPage(name: helpSupport, page: () => const HelpSupportScreen()),
    GetPage(name: privacyPolicy, page: () => const PrivacyPolicyScreen()),
    GetPage(name: termsOfServices, page: () => const TermsAndConditionsScreen()),
    GetPage(name: allCoachFeedback, page: () => const AllCoachFeedbackScreen()),
  ];
}
