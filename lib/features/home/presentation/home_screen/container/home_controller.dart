import 'package:football_club/features/home/data/repository_impl/home_repository_impl.dart';
import 'package:football_club/features/home/domain/entity/home_entity.dart';
import 'package:football_club/features/home/domain/repository/home_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeRepository homeRepository;

  HomeController({HomeRepository? homeRepository})
      : homeRepository = homeRepository ?? HomeRepositoryImpl();

  var isLoading = false.obs;
  final homeEntity = Rxn<HomeEntity>();

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
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
}
