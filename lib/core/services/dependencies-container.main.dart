part of 'dependencies-container.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
  await _initCourse();
  await _initVideo();
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

Future<void> _initCourse() async {
  getIt
    ..registerLazySingleton<CourseDataSource>(
      () => CourseFirebaseDataSource(
        authClient: getIt<FirebaseAuth>(),
        cloudStoreClient: getIt<FirebaseFirestore>(),
        dbClient: getIt<FirebaseStorage>(),
      ),
    )
    ..registerLazySingleton<ICourseRepository>(
        () => CourseRepository(getIt<CourseDataSource>()))
    ..registerLazySingleton<AddCourseUseCase>(
        () => AddCourseUseCase(getIt<ICourseRepository>()))
    ..registerLazySingleton<GetCoursesUseCase>(
        () => GetCoursesUseCase(getIt<ICourseRepository>()))
    ..registerFactory<CourseCubit>(() => CourseCubit(
        addCourse: getIt<AddCourseUseCase>(),
        getCourses: getIt<GetCoursesUseCase>()));
}

Future<void> _initVideo() async {
  getIt
    ..registerLazySingleton<VideoDataSource>(
      () => VideoFirebaseDataSource(
        auth: getIt<FirebaseAuth>(),
        firestore: getIt<FirebaseFirestore>(),
        storage: getIt<FirebaseStorage>(),
      ),
    )
    ..registerLazySingleton<IVideoRepository>(
        () => VideoRepository(getIt<VideoDataSource>()))
    ..registerLazySingleton<AddVideoUseCase>(
        () => AddVideoUseCase(getIt<IVideoRepository>()))
    ..registerLazySingleton<GetVideosUseCase>(
        () => GetVideosUseCase(getIt<IVideoRepository>()))
    ..registerFactory<VideoCubit>(() => VideoCubit(
        addVideo: getIt<AddVideoUseCase>(),
        getVideos: getIt<GetVideosUseCase>()));
}
