import 'package:education_app/core/utils/typedefs.dart';

abstract interface class IOnBoardingRepository{
  const IOnBoardingRepository();
  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}