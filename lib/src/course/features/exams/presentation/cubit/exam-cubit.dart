import 'package:bloc/bloc.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam-question.entities.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.entities.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user-exam.entities.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/get-exam-questions.usecase.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/get-exams.usecase.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/get-user-course-exams.usecase.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/get-user-exam.usecase.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/submit-exam.usecase.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/update-exam.usecase.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/upload-exam.usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'exam-state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit({
    required GetExamsUseCase getExams,
    required GetExamQuestionsUseCase getExamQuestions,
    required GetUserExamUseCase getUserExams,
    required GetUserCourseExamsUseCase getUserCourseExams,
    required UploadExamUseCase uploadExam,
    required UpdateExamUseCase updateExam,
    required SubmitExamUseCase submitExam,
  })  : _getExams = getExams,
        _getExamQuestions = getExamQuestions,
        _getUserExams = getUserExams,
        _getUserCourseExams = getUserCourseExams,
        _uploadExam = uploadExam,
        _updateExam = updateExam,
        _submitExam = submitExam,
        super(const ExamInitial());
  final GetExamsUseCase _getExams;
  final GetExamQuestionsUseCase _getExamQuestions;
  final GetUserExamUseCase _getUserExams;
  final GetUserCourseExamsUseCase _getUserCourseExams;
  final UploadExamUseCase _uploadExam;
  final UpdateExamUseCase _updateExam;
  final SubmitExamUseCase _submitExam;
  Future<void> getExams(String courseId) async {
    emit(const GettingExams());
    final result = await _getExams(courseId);
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (exams) => emit(ExamsLoaded(exams)),
    );
  }

  Future<void> getExamQuestions(Exam exam) async {
    emit(const GettingExamQuestions());
    final result = await _getExamQuestions(exam);
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (questions) => emit(ExamQuestionsLoaded(questions)),
    );
  }
  
  Future<void> submitExam(UserExam exam) async {
    emit(const SubmittingExam());
    final result = await _submitExam(exam);
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (_) => emit(const ExamSubmitted()),
    );
  }

  Future<void> updateExam(Exam exam) async {
    emit(const UpdatingExam());
    final result = await _updateExam(exam);
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (_) => emit(const ExamUpdated()),
    );
  }

  Future<void> uploadExam(Exam exam) async {
    emit(const UploadingExam());
    final result = await _uploadExam(exam);
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (_) => emit(const ExamUploaded()),
    );
  }

  Future<void> getUserCourseExams(String courseId) async {
    emit(const GettingUserExams());
    final result = await _getUserCourseExams(courseId);
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (exams) => emit(UserCourseExamsLoaded(exams)),
    );
  }

  Future<void> getUserExams() async {
    emit(const GettingUserExams());
    final result = await _getUserExams();
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (exams) => emit(UserExamsLoaded(exams)),
    );
  }
}
