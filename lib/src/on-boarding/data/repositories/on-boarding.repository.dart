import 'package:dartz/dartz.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on-boarding/data/datasources/on-boarding-local-data-source.dart';
import 'package:education_app/src/on-boarding/domain/repositories/on-boarding.repository.dart';

class OnBoardingRepository implements IOnBoardingRepository {
  const OnBoardingRepository(this._dataSource);
  final OnBoardingLocalDataSource _dataSource;
  @override
  ResultFuture<void> cacheFirstTimer() async {
   
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() {
    // TODO: implement checkIfUserIsFirstTimer
    throw UnimplementedError();
  }
}
