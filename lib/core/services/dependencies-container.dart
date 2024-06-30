import 'package:education_app/src/on-boarding/data/datasources/on-boarding-local-data-source.dart';
import 'package:education_app/src/on-boarding/data/repositories/on-boarding.repository.dart';
import 'package:education_app/src/on-boarding/domain/repositories/on-boarding.repository.dart';
import 'package:education_app/src/on-boarding/domain/usecases/cache-first-timer.usecase.dart';
import 'package:education_app/src/on-boarding/domain/usecases/check-if-user-first-timer.usecase.dart';
import 'package:education_app/src/on-boarding/presentation/cubit/cubit/on-boarding-cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  getIt
    ..registerFactory(() => OnBoardingCubit(
        cacheFirstTimerUseCase: getIt(), checkIfUserFirstTimerUseCase: getIt))
    ..registerLazySingleton(() => CacheFirstTimerUseCase(getIt()))
    ..registerLazySingleton(() => CheckIfUserFirstTimerUseCase(getIt()))
    ..registerLazySingleton<IOnBoardingRepository>(
        () => OnBoardingRepository(getIt()))
    ..registerLazySingleton<IOnBoardingLocalDataSource>(
        () => OnBoardingLocalDataSource(getIt()))
    ..registerLazySingleton(() => prefs);
}
