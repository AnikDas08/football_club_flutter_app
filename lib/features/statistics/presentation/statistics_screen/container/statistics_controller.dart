import 'package:football_club/features/statistics/data/repository_impl/statistics_repository_impl.dart';
import 'package:football_club/features/statistics/domain/entity/statistics_entity.dart';
import 'package:football_club/features/statistics/domain/repository/statistics_repository.dart';
import 'package:get/get.dart';

class StatisticsController extends GetxController {
  final StatisticsRepository statisticsRepository;

  StatisticsController({StatisticsRepository? statisticsRepository})
      : statisticsRepository =
            statisticsRepository ?? StatisticsRepositoryImpl();

  var isLoading = false.obs;
  final statisticsEntity = Rxn<StatisticsEntity>();

  @override
  void onInit() {
    super.onInit();
    fetchStatisticsData();
  }

  Future<void> fetchStatisticsData() async {
    try {
      isLoading.value = true;
      final data = await statisticsRepository.getStatisticsData();
      if (data != null) {
        statisticsEntity.value = data;
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }
}
