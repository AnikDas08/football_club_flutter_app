import 'package:football_club/features/home/data/repository_impl/home_repository_impl.dart';
import 'package:football_club/features/home/domain/entity/home_entity.dart';
import 'package:football_club/features/home/domain/repository/home_repository.dart';
import 'package:football_club/utils/helpers/banner_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeRepository homeRepository;

  HomeController({HomeRepository? homeRepository})
      : homeRepository = homeRepository ?? HomeRepositoryImpl();

  var isLoading = false.obs;
  final homeEntity = Rxn<HomeEntity>();
  var bannerUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
    fetchHomeBanner();
  }

  Future<void> fetchHomeData() async {
    try {
      isLoading.value = true;
      final data = await homeRepository.getHomeDashboardData();
      if (data != null) {
        homeEntity.value = data;
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  void updatePlayerProfileLocally({
    String? name,
    String? imagePath,
    String? position,
  }) {
    if (homeEntity.value != null) {
      final current = homeEntity.value!;
      final newName = (name != null && name.isNotEmpty) ? name : current.playerName;
      final newImage = (imagePath != null && imagePath.isNotEmpty) ? imagePath : current.playerImagePath;

      String newSubtitle = current.playerSubtitle;
      if (position != null && position.isNotEmpty) {
        if (newSubtitle.contains('·')) {
          final parts = newSubtitle.split('·');
          newSubtitle = '${parts.first.trim()} · $position';
        } else {
          newSubtitle = position;
        }
      }

      homeEntity.value = HomeEntity(
        sessionsCount: current.sessionsCount,
        goalsCount: current.goalsCount,
        assistsCount: current.assistsCount,
        potmCount: current.potmCount,
        playerName: newName,
        playerLevel: current.playerLevel,
        playerSubtitle: newSubtitle,
        playerProgress: current.playerProgress,
        playerImagePath: newImage,
        trainingTitle: current.trainingTitle,
        daysLeftText: current.daysLeftText,
        trainingDateText: current.trainingDateText,
        trainingLocationText: current.trainingLocationText,
        trainingCoachName: current.trainingCoachName,
        trainingCoachAvatar: current.trainingCoachAvatar,
        goalCategoryTitle: current.goalCategoryTitle,
        goalStatusText: current.goalStatusText,
        goalTitle: current.goalTitle,
        goalDescription: current.goalDescription,
        goalProgress: current.goalProgress,
        goalDueDate: current.goalDueDate,
        feedbackTitle: current.feedbackTitle,
        feedbackCoachName: current.feedbackCoachName,
        feedbackDate: current.feedbackDate,
        feedbackContent: current.feedbackContent,
        feedbackAvatarPath: current.feedbackAvatarPath,
        allCoachFeedbacks: current.allCoachFeedbacks,
        achievementCategory: current.achievementCategory,
        achievementTitle: current.achievementTitle,
        matchInfo: current.matchInfo,
      );
    }
  }

  Future<void> fetchHomeBanner() async {
    try {
      final url = await BannerHelper.fetchBanner('home');
      if (url != null && url.isNotEmpty) {
        bannerUrl.value = url;
      }
    } catch (_) {}
  }
}
