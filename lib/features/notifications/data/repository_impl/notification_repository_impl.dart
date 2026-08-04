import '../../domain/entity/notification_entity.dart';
import '../../domain/repository/notification_repository.dart';
import '../remote_data_source/notification_remote_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({NotificationRemoteDataSource? remoteDataSource})
      : remoteDataSource =
            remoteDataSource ?? NotificationRemoteDataSourceImpl();

  @override
  Future<List<NotificationEntity>> getNotifications(int page) async {
    return await remoteDataSource.getNotifications(page);
  }
}
