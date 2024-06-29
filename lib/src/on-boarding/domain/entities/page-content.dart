import 'package:education_app/core/global/media.dart';
import 'package:equatable/equatable.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  const PageContent.first()
      : this(
          image: MediaRes.casualReading,
          title: 'Brand new curriculum',
          description:
              'This is the first online education platform designed by the '
              "world's top professors",
        );

  const PageContent.second()
      : this(
          image: MediaRes.casualLife,
          title: 'Brand a fun atmosphere',
          description:
              'This is the first online education platform designed by the '
              "world's top professors",
        );

  const PageContent.third()
      : this(
          image: MediaRes.casualMeditationScience,
          title: 'Easy to join the lesson',
          description:
              'This is the first online education platform designed by the '
              "world's top professors",
        );

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
