import 'package:get_it/get_it.dart';
import '../../feature/user_profile/repository/user_interfaces.dart';
import '../../feature/user_profile/repository/user_repository_impl.dart';

final sl = GetIt.instance;

void init() {
  final repository = UserRepositoryImpl();
  sl.registerLazySingleton<UserReader>(() => repository);
  sl.registerLazySingleton<UserWriter>(() => repository);
  sl.registerLazySingleton<UserDeleter>(() => repository);
}
