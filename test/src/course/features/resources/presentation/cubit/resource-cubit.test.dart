
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/course/features/resources/data/models/resource.models.dart';
import 'package:education_app/src/course/features/resources/domain/usecases/add-resource.usecase.dart';
import 'package:education_app/src/course/features/resources/domain/usecases/get-resources.usecase.dart';
import 'package:education_app/src/course/features/resources/presentation/cubit/resource-cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAddResource extends Mock implements AddResourceUseCase {}

class MockGetResources extends Mock implements GetResourcesUseCase {}

void main() {
  late AddResourceUseCase addResource;
  late GetResourcesUseCase getResources;
  late ResourceCubit resourceCubit;

  final tResource = ResourceModel.empty();

  setUp(() {
    addResource = MockAddResource();
    getResources = MockGetResources();
    resourceCubit = ResourceCubit(
      addResource: addResource,
      getResources: getResources,
    );
    registerFallbackValue(tResource);
  });

  tearDown(() {
    resourceCubit.close();
  });

  test(
    'initial state should be [ResourceInitial]',
    () async {
      expect(resourceCubit.state, const ResourceInitial());
    },
  );

  group('addResource', () {
    blocTest<ResourceCubit, ResourceState>(
      'emits [AddingResources, ResourcesAdded] when addResource is called',
      build: () {
        when(() => addResource(any()))
            .thenAnswer((_) async => const Right(null));
        return resourceCubit;
      },
      act: (cubit) => cubit.addResources([tResource]),
      expect: () => const <ResourceState>[
        AddingResource(),
        ResourceAdded(),
      ],
      verify: (_) {
        verify(() => addResource(tResource)).called(1);
        verifyNoMoreInteractions(addResource);
      },
    );

    blocTest<ResourceCubit, ResourceState>(
      'emits [AddingResources, ResourceError] when '
      'addResource is called and fails',
      build: () {
        when(() => addResource(any())).thenAnswer(
          (_) async => Left(
            ServerFailure(message: 'Server Failure', statusCode: 500),
          ),
        );
        return resourceCubit;
      },
      act: (cubit) => cubit.addResources([tResource]),
      expect: () => const <ResourceState>[
        AddingResource(),
        ResourceError('500 Error: Server Failure'),
      ],
      verify: (_) {
        verify(() => addResource(tResource)).called(1);
        verifyNoMoreInteractions(addResource);
      },
    );
  });

  group('getResources', () {
    blocTest<ResourceCubit, ResourceState>(
      'emits [LoadingResources, ResourcesLoaded] when getResources is called',
      build: () {
        when(() => getResources(any()))
            .thenAnswer((_) async => const Right([]));
        return resourceCubit;
      },
      act: (cubit) => cubit.getResources('testId'),
      expect: () => const <ResourceState>[
        LoadingResources(),
        ResourcesLoaded([]),
      ],
      verify: (_) {
        verify(() => getResources('testId')).called(1);
        verifyNoMoreInteractions(getResources);
      },
    );

    blocTest<ResourceCubit, ResourceState>(
      'emits [LoadingResources, ResourceError] when getResources '
      'is called and fails',
      build: () {
        when(() => getResources(any())).thenAnswer(
          (_) async => Left(
            ServerFailure(message: 'Server Failure', statusCode: 500),
          ),
        );
        return resourceCubit;
      },
      act: (cubit) => cubit.getResources('testId'),
      expect: () => const <ResourceState>[
        LoadingResources(),
        ResourceError('500 Error: Server Failure'),
      ],
      verify: (_) {
        verify(() => getResources('testId')).called(1);
        verifyNoMoreInteractions(getResources);
      },
    );
  });
}
