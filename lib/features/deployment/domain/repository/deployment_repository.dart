import 'package:football_club/features/deployment/domain/entity/deployment_entity.dart';

abstract class DeploymentRepository {
  Future<DeploymentEntity?> getDeploymentData();
}
