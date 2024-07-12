import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/data/datasources/exam.data-source.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam-question.entities.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.entities.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user-exam.entities.dart';
import 'package:education_app/src/course/features/exams/domain/repository/exam.repositories.dart';

class ExamRepository implements IExamRepository {
  const ExamRepository(this._dataSource);
  final ExamDataSource _dataSource;
  @override
  ResultFuture<List<ExamQuestion>> getExamQuestions(Exam exam) async {
    try {
      return Right(await _dataSource.getExamQuestions(exam));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Exam>> getExams(String courseId) async {
    try {
      return Right(await _dataSource.getExams(courseId));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<UserExam>> getUserCourseExams(String courseId) async {
    try {
      return Right(await _dataSource.getUserCourseExams(courseId));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<UserExam>> getUserExams() async {
    try {
      return Right(await _dataSource.getUserExams());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> submitExam(UserExam userExam) async {
    try {
      return Right(await _dataSource.submitExam(userExam));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateExam(Exam exam) async {
    try {
      return Right(await _dataSource.updateExam(exam));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> uploadExam(Exam exam) async {
    try {
      return Right(await _dataSource.updateExam(exam));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
