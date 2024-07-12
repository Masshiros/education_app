
import 'package:dartz/dartz.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.entities.dart';
import 'package:education_app/src/course/features/videos/domain/repositories/video.repositories.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/get-videos.usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'video.repositories.mock.dart';

void main() {
  late IVideoRepository repo;
  late GetVideosUseCase usecase;

  setUp(() {
    repo = MockVideoRepo();
    usecase = GetVideosUseCase(repo);
  });

  final tVideo = Video.empty();

  test('should call [VideoRepo.addVideo]', () async {
    when(() => repo.getVideos(any())).thenAnswer((_) async => Right([tVideo]));

    final result = await usecase('testId');

    expect(result, isA<Right<dynamic, List<Video>>>());
    verify(() => repo.getVideos('testId')).called(1);
    verifyNoMoreInteractions(repo);
  });
}