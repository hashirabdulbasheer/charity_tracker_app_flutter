import 'package:get_it/get_it.dart';
import '../../features/charity/data/repositories/charity_repository_impl.dart';
import '../../features/charity/domain/repositories/charity_repository.dart';
import '../../features/charity/domain/use_cases/create_charity_use_case.dart';
import '../../features/charity/domain/use_cases/get_all_charities_use_case.dart';
import '../../features/charity/data/data_sources/charity_firebase_datasource.dart';
import '../../features/charity/domain/use_cases/delete_charity_use_case.dart';
import '../../features/charity/domain/use_cases/update_charity_use_case.dart';

final sl = GetIt.instance;

class CharityDIContainer {
  static Future<void> init() async {
    /// register data sources
    sl.registerLazySingleton<CharityFirebaseDataSource>(() => CharityFirebaseDataSourceImpl());

    /// register repositories
    sl.registerLazySingleton<CharityRepository>(() => CharityRepositoryImpl(dataSource: sl()));

    /// register use-cases
    sl.registerLazySingleton(() => CharityCreateUseCase(repository: sl()));
    sl.registerLazySingleton(() => CharityUpdateUseCase(repository: sl()));
    sl.registerLazySingleton(() => CharityDeleteUseCase(repository: sl()));
    sl.registerLazySingleton(() => GetAllCharitiesUseCase(repository: sl()));
  }
}
