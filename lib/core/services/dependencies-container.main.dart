part of 'dependencies-container.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
}

Future<void> _initOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();

  getIt
    // Register others
    ..registerLazySingleton<SharedPreferences>(() => prefs)

    // Register data sources
    ..registerLazySingleton<IOnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSource(getIt<SharedPreferences>()),
    )

    // Register repositories
    ..registerLazySingleton<IOnBoardingRepository>(
      () => OnBoardingRepository(getIt<IOnBoardingLocalDataSource>()),
    )

    // Register use cases
    ..registerLazySingleton<CacheFirstTimerUseCase>(
      () => CacheFirstTimerUseCase(getIt<IOnBoardingRepository>()),
    )
    ..registerLazySingleton<CheckIfUserFirstTimerUseCase>(
      () => CheckIfUserFirstTimerUseCase(getIt<IOnBoardingRepository>()),
    )

    // Register Cubit
    ..registerFactory<OnBoardingCubit>(
      () => OnBoardingCubit(
        cacheFirstTimerUseCase: getIt<CacheFirstTimerUseCase>(),
        checkIfUserFirstTimerUseCase: getIt<CheckIfUserFirstTimerUseCase>(),
      ),
    );
}

Future<void> _initAuth() async {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  getIt
    ..registerLazySingleton<FirebaseAuth>(() => firebaseAuth)
    ..registerLazySingleton<FirebaseStorage>(() => firebaseStorage)
    ..registerLazySingleton<FirebaseFirestore>(() => firebaseFirestore)
    ..registerLazySingleton<AuthDataSource>(() => FirebaseDataSource(
          authClient: getIt<FirebaseAuth>(),
          cloudStoreClient: getIt<FirebaseFirestore>(),
          dbClient: getIt<FirebaseStorage>(),
        ))
    ..registerLazySingleton<IAuthRepository>(
        () => AuthRepository(getIt<AuthDataSource>()))
    ..registerLazySingleton<SignInUseCase>(
        () => SignInUseCase(getIt<IAuthRepository>()))
    ..registerLazySingleton<SignUpUseCase>(
        () => SignUpUseCase(getIt<IAuthRepository>()))
    ..registerLazySingleton<UpdateUserUseCase>(
        () => UpdateUserUseCase(getIt<IAuthRepository>()))
    ..registerLazySingleton<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(getIt<IAuthRepository>()))
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        signInUseCase: getIt<SignInUseCase>(),
        signUpUseCase: getIt<SignUpUseCase>(),
        forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
        updateUserUseCase: getIt<UpdateUserUseCase>(),
      ),
    );
}
