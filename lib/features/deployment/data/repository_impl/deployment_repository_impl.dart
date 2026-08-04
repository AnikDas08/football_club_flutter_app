import 'package:football_club/features/deployment/data/model/deployment_model.dart';
import 'package:football_club/features/deployment/data/remote_data_source/deployment_remote_data_source.dart';
import 'package:football_club/features/deployment/domain/entity/deployment_entity.dart';
import 'package:football_club/features/deployment/domain/repository/deployment_repository.dart';

class DeploymentRepositoryImpl implements DeploymentRepository {
  final DeploymentRemoteDataSource remoteDataSource;

  DeploymentRepositoryImpl({DeploymentRemoteDataSource? remoteDataSource})
      : remoteDataSource =
            remoteDataSource ?? DeploymentRemoteDataSourceImpl();

  @override
  Future<DeploymentEntity?> getDeploymentData() async {
    final response = await remoteDataSource.fetchDeploymentData();
    if (response.statusCode == 200) {
      final data = response.data['data'] ?? {};
      return DeploymentModel.fromJson(data);
    }
    return null;
  }
}
