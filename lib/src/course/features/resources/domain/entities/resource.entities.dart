
import 'package:equatable/equatable.dart';

class Resource extends Equatable {
  const Resource({
    required this.id,
    required this.courseId,
    required this.uploadDate,
    required this.fileURL,
    required this.isFile,
    required this.fileExtension,
    this.title,
    this.author,
    this.description,
  });

  Resource.empty([DateTime? date])
      : this(
          id: '_empty.id',
          title: '_empty.title',
          description: '_empty.description',
          uploadDate: date ?? DateTime.now(),
          fileExtension: '_empty.fileExtension',
          isFile: true,
          courseId: '_empty.courseId',
          fileURL: '_empty.fileURL',
          author: '_empty.author',
        );

  final String id;
  final String courseId;
  final DateTime uploadDate;
  final String fileURL;
  final String fileExtension;
  final bool isFile;
  final String? title;
  final String? author;
  final String? description;

  @override
  List<Object?> get props => [id, courseId];
}
