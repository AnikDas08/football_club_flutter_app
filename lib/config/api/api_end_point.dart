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
  static const changePassword = 'auth/change-password';
  static const user = 'users';
  static const notifications = 'notifications';
  static const privacyPolicies = 'privacy-policies';
  static const termsOfServices = 'terms-and-conditions';
  static const chats = 'chats';
  static const messages = 'messages';
  static const faqsPublic = 'faqs/public';

  static String playerProfile(String playerId) =>
      'dashboard/player/profile/$playerId';
  static String upcomingTraining(String playerId) =>
      'dashboard/player/upcoming-training/$playerId';
  static String currentTarget(String playerId) =>
      'dashboard/player/current-target/$playerId';
  static String latestFeedback(String playerId) =>
      'dashboard/player/feedback/$playerId';
  static String sessionNotes(String playerId, {int page = 1, int limit = 10}) =>
      'session-notes/my-notes/$playerId?page=$page&limit=$limit';
  static String overallScore(String playerId) =>
      'assessment/player-development/$playerId/overall';
  static String coreAreas(String playerId) =>
      'assessment/player-development/$playerId/core-areas';
  static String footballSkills(String playerId) =>
      'assessment/player-development/$playerId/skills';
  static String growthChart(String playerId) =>
      'assessment/player-development/$playerId/growth-chart';
  static String myTargets(String playerId, {int page = 1, int limit = 10}) =>
      'targets/my-targets/$playerId?page=$page&limit=$limit';
  static String developmentTimeline(String playerId) =>
      'assessment/player-development/$playerId/timeline';
  static String myAchievements(String playerId) =>
      'achievements/my-achievements/$playerId';
  static String playerStats(String playerId) =>
      'dashboard/player/stats/$playerId';
  static String developmentStats(String playerId) =>
      'dashboard/get-development-stats/$playerId';
  static const userProfile = 'users/profile';
  static const notificationPreferences = 'notification/preferences';
  static String banners(String section) => 'banners?section=$section';
}
