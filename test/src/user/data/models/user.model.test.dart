
void main() {
  const tLocalUserModel = LocalUserModel.empty();

  test(
    'should be a subclass of [LocalUser] entity',
    () => expect(tLocalUserModel, isA<LocalUser>()),
  );

  final tMap = jsonDecode(fixture('user.json')) as DataMap;

  group('fromMap', () {
    test(
      'should return a valid [LocalUserModel] from the map',
      () {
        // act
        final result = LocalUserModel.fromMap(tMap);

        expect(result, isA<LocalUserModel>());
        expect(result, equals(tLocalUserModel));
      },
    );

    test(
      'should throw an [Error] when the map is invalid',
      () {
        final map = DataMap.from(tMap)..remove('uid');

        const call = LocalUserModel.fromMap;

        expect(() => call(map), throwsA(isA<Error>()));
      },
    );
  });

  group('toMap', () {
    test('should return a valid [DataMap] from the model', () {
      final result = tLocalUserModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test(
      'should return a valid [LocalUserModel] with updated values',
      () {
        final result = tLocalUserModel.copyWith(uid: '2');

        expect(result.uid, '2');
      },
    );
  });
}
