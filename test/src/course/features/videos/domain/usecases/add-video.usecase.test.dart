
import 'package:dartz/dartz.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.entities.dart';
import 'package:education_app/src/course/features/videos/domain/repositories/video.repositories.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/add-video.usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'video.repositories.mock.dart';

void main() {
  late IVideoRepository repo;
  late AddVideoUseCase usecase;

  final tVideo = Video.empty();
  setUp(() {
    repo = MockVideoRepo();
    usecase = AddVideoUseCase(repo);
    registerFallbackValue(tVideo);
  });

  test('should call [VideoRepo.addVideo]', () async {
    when(() => repo.addVideo(any())).thenAnswer((_) async => const Right(null));

    final result = await usecase(tVideo);

    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repo.addVideo(tVideo)).called(1);
    verifyNoMoreInteractions(repo);
  });
}