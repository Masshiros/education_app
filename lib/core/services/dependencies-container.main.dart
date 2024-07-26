part of 'dependencies-container.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
  await _initCourse();
  await _initVideo();
  await _initResource();
  await _initExam();
  await _initNotification();
  await _initChat();
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

Future<void> _initResource() async {
  getIt
    ..registerLazySingleton<ResourceDataSource>(
      () => ResourceFirebaseDataSource(
        auth: getIt<FirebaseAuth>(),
        firestore: getIt<FirebaseFirestore>(),
        storage: getIt<FirebaseStorage>(),
      ),
    )
    ..registerLazySingleton<IResourceRepository>(
        () => ResourceRepository(getIt<ResourceDataSource>()))
    ..registerLazySingleton<AddResourceUseCase>(
        () => AddResourceUseCase(getIt<IResourceRepository>()))
    ..registerLazySingleton<GetResourcesUseCase>(
        () => GetResourcesUseCase(getIt<IResourceRepository>()))
    ..registerFactory<ResourceCubit>(() => ResourceCubit(
        addResource: getIt<AddResourceUseCase>(),
        getResources: getIt<GetResourcesUseCase>()))
    ..registerFactory<ResourceProvider>(() => ResourceProvider(
          storage: getIt<FirebaseStorage>(),
          prefs: getIt<SharedPreferences>(),
        ));
}

Future<void> _initExam() async {
  getIt
    ..registerLazySingleton<ExamDataSource>(
      () => ExamFirebaseDataSource(
        auth: getIt<FirebaseAuth>(),
        firestore: getIt<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton<IExamRepository>(
        () => ExamRepository(getIt<ExamDataSource>()))
    ..registerLazySingleton<GetExamQuestionsUseCase>(
        () => GetExamQuestionsUseCase(getIt<IExamRepository>()))
    ..registerLazySingleton<GetExamsUseCase>(
        () => GetExamsUseCase(getIt<IExamRepository>()))
    ..registerLazySingleton<GetUserExamUseCase>(
        () => GetUserExamUseCase(getIt<IExamRepository>()))
    ..registerLazySingleton<GetUserCourseExamsUseCase>(
        () => GetUserCourseExamsUseCase(getIt<IExamRepository>()))
    ..registerLazySingleton<UploadExamUseCase>(
        () => UploadExamUseCase(getIt<IExamRepository>()))
    ..registerLazySingleton<UpdateExamUseCase>(
        () => UpdateExamUseCase(getIt<IExamRepository>()))
    ..registerLazySingleton<SubmitExamUseCase>(
        () => SubmitExamUseCase(getIt<IExamRepository>()))
    ..registerFactory<ExamCubit>(() => ExamCubit(
          getExamQuestions: getIt<GetExamQuestionsUseCase>(),
          getExams: getIt<GetExamsUseCase>(),
          getUserExams: getIt<GetUserExamUseCase>(),
          getUserCourseExams: getIt<GetUserCourseExamsUseCase>(),
          uploadExam: getIt<UploadExamUseCase>(),
          updateExam: getIt<UpdateExamUseCase>(),
          submitExam: getIt<SubmitExamUseCase>(),
        ));
}

Future<void> _initNotification() async {
  getIt
    ..registerLazySingleton<NotificationDataSource>(
      () => NotificationFirebaseDataSource(
        auth: getIt<FirebaseAuth>(),
        firestore: getIt<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton<INotificationRepository>(
        () => NotificationRepository(getIt<NotificationDataSource>()))
    ..registerLazySingleton<GetNotificationsUseCase>(
        () => GetNotificationsUseCase(getIt<INotificationRepository>()))
    ..registerLazySingleton<SendNotificationUseCase>(
        () => SendNotificationUseCase(getIt<INotificationRepository>()))
    ..registerLazySingleton<MarkAsReadUseCase>(
        () => MarkAsReadUseCase(getIt<INotificationRepository>()))
    ..registerLazySingleton<ClearAllUseCase>(
        () => ClearAllUseCase(getIt<INotificationRepository>()))
    ..registerLazySingleton<ClearUseCase>(
        () => ClearUseCase(getIt<INotificationRepository>()))
    ..registerFactory<NotificationsCubit>(() => NotificationsCubit(
          clear: getIt<ClearUseCase>(),
          clearAll: getIt<ClearAllUseCase>(),
          getNotifications: getIt<GetNotificationsUseCase>(),
          markAsRead: getIt<MarkAsReadUseCase>(),
          sendNotification: getIt<SendNotificationUseCase>(),
        ));
}

Future<void> _initChat() async {
  getIt
    ..registerLazySingleton<ChatDataSource>(
      () => ChatFirebaseDataSource(
        auth: getIt<FirebaseAuth>(),
        firestore: getIt<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton<IChatRepositories>(
        () => ChatRepository(getIt<ChatDataSource>()))
    ..registerLazySingleton<GetGroupsUseCase>(
        () => GetGroupsUseCase(getIt<IChatRepositories>()))
    ..registerLazySingleton<GetMessagesUseCase>(
        () => GetMessagesUseCase(getIt<IChatRepositories>()))
    ..registerLazySingleton<GetUserByIdUseCase>(
        () => GetUserByIdUseCase(getIt<IChatRepositories>()))
    ..registerLazySingleton<JoinGroupUseCase>(
        () => JoinGroupUseCase(getIt<IChatRepositories>()))
    ..registerLazySingleton<LeaveGroupUseCase>(
        () => LeaveGroupUseCase(getIt<IChatRepositories>()))
    ..registerLazySingleton<SendMessageUseCase>(
        () => SendMessageUseCase(getIt<IChatRepositories>()))
    ..registerFactory<ChatCubit>(() => ChatCubit(
          getGroups: getIt<GetGroupsUseCase>(),
          getMessages: getIt<GetMessagesUseCase>(),
          getUserById: getIt<GetUserByIdUseCase>(),
          joinGroup: getIt<JoinGroupUseCase>(),
          leaveGroup: getIt<LeaveGroupUseCase>(),
          sendMessage: getIt<SendMessageUseCase>(),
        ));
}
