import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on-boarding/data/datasources/on-boarding-local-data-source.dart';
import 'package:education_app/src/on-boarding/domain/repositories/on-boarding.repository.dart';

class OnBoardingRepository implements IOnBoardingRepository {
  const OnBoardingRepository(this._dataSource);
  final OnBoardingLocalDataSource _dataSource;
  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _dataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      return Right(await _dataSource.checkIfUserIsFirstTimer());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
