import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/src/on-boarding/data/datasources/on-boarding-local-data-source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnBoardingLocalDataSource localDataSource;

  setUp(() {
    prefs = MockSharedPreferences();
    localDataSource = OnBoardingLocalDataSource(prefs);
  });

  group('cacheFirstTimer', () {
    test(
      'should call [SharedPreferences] to cache the data',
      () async {
        when(() => prefs.setBool(any(), any())).thenAnswer((_) async => true);

        await localDataSource.cacheFirstTimer();

        verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
        verifyNoMoreInteractions(prefs);
      },
    );

    test(
      'should throw a [CacheException] when there is an error caching the data',
      () async {
        when(() => prefs.setBool(any(), any())).thenThrow(Exception());

        final methodCall = localDataSource.cacheFirstTimer;

        expect(methodCall, throwsA(isA<CacheException>()));
        verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
        verifyNoMoreInteractions(prefs);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    test(
      'should call [SharedPreferences] to check if user is first timer and '
      'return the right response from storage when data exists',
      () async {
        when(() => prefs.getBool(any())).thenReturn(false);

        final result = await localDataSource.checkIfUserIsFirstTimer();

        expect(result, false);

        verify(() => prefs.getBool(kFirstTimerKey)).called(1);

        verifyNoMoreInteractions(prefs);
      },
    );

    test(
      'should return true if there is no data in storage',
      () async {
        when(() => prefs.getBool(any())).thenReturn(null);

        final result = await localDataSource.checkIfUserIsFirstTimer();

        expect(result, true);

        verify(() => prefs.getBool(kFirstTimerKey)).called(1);

        verifyNoMoreInteractions(prefs);
      },
    );

    test(
      'should throw a [CacheException] when there is an error '
      'retrieving the data',
      () async {
        when(() => prefs.getBool(any())).thenThrow(Exception());
        final call = localDataSource.checkIfUserIsFirstTimer;

        expect(call, throwsA(isA<CacheException>()));
        verify(() => prefs.getBool(kFirstTimerKey)).called(1);

        verifyNoMoreInteractions(prefs);
      },
    );
  });
}