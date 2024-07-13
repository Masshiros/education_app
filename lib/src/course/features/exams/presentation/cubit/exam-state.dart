part of 'exam-cubit.dart';

abstract class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object> get props => [];
}

class ExamInitial extends ExamState {
  const ExamInitial();
}

class GettingExams extends ExamState {
  const GettingExams();
}

class GettingUserExams extends ExamState {
  const GettingUserExams();
}

class GettingExamQuestions extends ExamState {
  const GettingExamQuestions();
}

class SubmittingExam extends ExamState {
  const SubmittingExam();
}

class UploadingExam extends ExamState {
  const UploadingExam();
}

class UpdatingExam extends ExamState {
  const UpdatingExam();
}

class ExamsLoaded extends ExamState {
  const ExamsLoaded(this.exams);

  final List<Exam> exams;

  @override
  List<Object> get props => [exams];
}

class UserCourseExamsLoaded extends ExamState {
  const UserCourseExamsLoaded(this.exams);

  final List<UserExam> exams;

  @override
  List<Object> get props => [exams];
}

class UserExamsLoaded extends ExamState {
  const UserExamsLoaded(this.exams);

  final List<UserExam> exams;

  @override
  List<Object> get props => [exams];
}

class ExamQuestionsLoaded extends ExamState {
  const ExamQuestionsLoaded(this.questions);

  final List<ExamQuestion> questions;

  @override
  List<Object> get props => [questions];
}

class ExamSubmitted extends ExamState {
  const ExamSubmitted();
}

class ExamUploaded extends ExamState {
  const ExamUploaded();
}

class ExamUpdated extends ExamState {
  const ExamUpdated();
}

class ExamError extends ExamState {
  const ExamError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

