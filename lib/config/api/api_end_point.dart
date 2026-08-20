class ApiEndPoint {
  static const baseUrl = 'http://10.10.26.180:5001/api/v1/';
  static const imageUrl = 'http://10.10.26.180:5001';
  static const socketUrl = 'http://10.10.26.180:5001';

  static const signUp = 'users/sign-up';
  static const verifyEmail = 'users/verify-email';
  static const signIn = 'auth/login';
  static const forgotPassword = 'auth/forget-password';
  static const verifyOtp = 'auth/verify-otp';
  static const resetPassword = 'auth/reset-password';
  static const changePassword = 'users/change-password';
  static const user = 'users';
  static const notifications = 'notifications';
  static const privacyPolicies = 'privacy-policies';
  static const termsOfServices = 'terms-and-conditions';
  static const chats = 'chats';
  static const messages = 'messages';

  static String playerProfile(String playerId) => 'dashboard/player/profile/$playerId';
  static String upcomingTraining(String playerId) => 'dashboard/player/upcoming-training/$playerId';
  static String currentTarget(String playerId) => 'dashboard/player/current-target/$playerId';
}
