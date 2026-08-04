import 'package:football_club/features/deployment/data/repository_impl/deployment_repository_impl.dart';
import 'package:football_club/features/deployment/domain/entity/deployment_entity.dart';
import 'package:football_club/features/deployment/domain/repository/deployment_repository.dart';
import 'package:get/get.dart';

class DeploymentController extends GetxController {
  final DeploymentRepository deploymentRepository;

  DeploymentController({DeploymentRepository? deploymentRepository})
      : deploymentRepository =
            deploymentRepository ?? DeploymentRepositoryImpl();

  var isLoading = false.obs;
  final deploymentEntity = Rxn<DeploymentEntity>();

  @override
  void onInit() {
    super.onInit();
    fetchDeploymentData();
  }

  Future<void> fetchDeploymentData() async {
    try {
      isLoading.value = true;
      final data = await deploymentRepository.getDeploymentData();
      if (data != null) {
        deploymentEntity.value = data;
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }
}
