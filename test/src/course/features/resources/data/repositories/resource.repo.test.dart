import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/course/features/resources/data/datasources/resource.data-source.dart';
import 'package:education_app/src/course/features/resources/data/models/resource.models.dart';
import 'package:education_app/src/course/features/resources/data/repositories/resource.repositories.dart';
import 'package:education_app/src/course/features/resources/domain/entities/resource.entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockResourceDataSource extends Mock implements ResourceDataSource {}

void main() {
  late ResourceDataSource remoteDataSource;
  late ResourceRepository repoImpl;

  final tResource = ResourceModel.empty();

  setUp(() {
    remoteDataSource = MockResourceDataSource();
    repoImpl = ResourceRepository(remoteDataSource);
    registerFallbackValue(tResource);
  });

  const tException = ServerException(
    message: 'Something went wrong',
    statusCode: '500',
  );

  group('addResource', () {
    test(
      'should complete successfully when call to remote source is '
      'successful',
      () async {
        when(() => remoteDataSource.addResource(any())).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repoImpl.addResource(tResource);

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(() => remoteDataSource.addResource(tResource)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSource.addResource(any())).thenThrow(tException);

        final result = await repoImpl.addResource(tResource);

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure.fromException(tException),
            ),
          ),
        );

        verify(() => remoteDataSource.addResource(tResource)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getResourceaddResources', () {
    test(
      'should complete successfully when call to remote source is '
      'successful',
      () async {
        when(() => remoteDataSource.getResources(any())).thenAnswer(
          (_) async => [tResource],
        );

        final result = await repoImpl.getResources('courseId');

        expect(result, isA<Right<dynamic, List<Resource>>>());

        verify(() => remoteDataSource.getResources('courseId')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSource.getResources(any())).thenThrow(tException);

        final result = await repoImpl.getResources('courseId');

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure.fromException(tException),
            ),
          ),
        );

        verify(() => remoteDataSource.getResources('courseId')).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
