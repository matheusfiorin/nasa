import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/core/error/failures.dart';
import 'package:nasa/src/core/network/network_info.dart';
import 'package:nasa/src/data/model/apod_hive_model.dart';
import 'package:nasa/src/data/model/apod_model.dart';
import 'package:nasa/src/data/repository/apod_repository_impl.dart';
import 'package:nasa/src/data/repository/contracts/apod_local_provider.dart';
import 'package:nasa/src/data/repository/contracts/apod_remote_provider.dart';
import 'package:nasa/src/domain/entity/apod.dart';

@GenerateNiceMocks([
  MockSpec<ApodRemoteProvider>(),
  MockSpec<ApodLocalProvider>(),
  MockSpec<NetworkInfo>(),
])
import 'apod_repository_impl_test.mocks.dart';

void main() {
  late ApodRepositoryImpl repository;
  late MockApodRemoteProvider mockRemoteProvider;
  late MockApodLocalProvider mockLocalProvider;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteProvider = MockApodRemoteProvider();
    mockLocalProvider = MockApodLocalProvider();
    mockNetworkInfo = MockNetworkInfo();
    repository = ApodRepositoryImpl(
      remoteProvider: mockRemoteProvider,
      localProvider: mockLocalProvider,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getApodList', () {
    final startDate = DateTime(2024, 3, 15);
    final endDate = DateTime(2024, 3, 16);
    const tApodModel = ApodModel(
      date: '2024-03-15',
      title: 'Test Title',
      explanation: 'Test Explanation',
      url: 'https://example.com/image.jpg',
      mediaType: 'image',
    );
    final tApodHiveModel = ApodHiveModel(
      date: '2024-03-15',
      title: 'Test Title',
      explanation: 'Test Explanation',
      url: 'https://example.com/image.jpg',
      mediaType: 'image',
    );

    test('should return cached data when available within date range',
        () async {
      when(mockLocalProvider.getApodList())
          .thenAnswer((_) async => [tApodHiveModel]);

      final result = await repository.getApodList(startDate, endDate);

      verify(mockLocalProvider.getApodList());
      expect(result.isRight(), true);
      expect((result as Right).value, isA<List<Apod>>());
      verifyNever(mockNetworkInfo.isConnected);
      verifyNever(mockRemoteProvider.getApodList(any, any));
    });

    test(
        'should return ServerFailure with correct message for unexpected errors',
        () async {
      when(mockLocalProvider.getApodList()).thenAnswer((_) async => []);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteProvider.getApodList(any, any))
          .thenThrow(Exception('Unexpected error'));

      final result = await repository.getApodList(startDate, endDate);

      expect(result.isLeft(), true);
      final failure = (result as Left).value as ServerFailure;
      expect(failure.message, 'Unexpected error: Exception: Unexpected error');
      verify(mockLocalProvider.getApodList());
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteProvider.getApodList(any, any));
    });

    test('should fetch from remote when cache is empty and has connection',
        () async {
      when(mockLocalProvider.getApodList()).thenAnswer((_) async => []);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteProvider.getApodList(any, any))
          .thenAnswer((_) async => [tApodModel]);
      when(mockLocalProvider.cacheApodList(any)).thenAnswer((_) async => {});

      final result = await repository.getApodList(startDate, endDate);

      verify(mockLocalProvider.getApodList());
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteProvider.getApodList(any, any));
      verify(mockLocalProvider.cacheApodList(any));
      expect(result.isRight(), true);
      expect((result as Right).value, isA<List<Apod>>());
    });

    test('should return CacheFailure when offline and no cache', () async {
      when(mockLocalProvider.getApodList()).thenAnswer((_) async => []);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.getApodList(startDate, endDate);

      expect(
        result,
        equals(const Left(
          CacheFailure('No cached data found and no internet connection'),
        )),
      );
    });

    test('should return ServerFailure when remote call fails', () async {
      when(mockLocalProvider.getApodList()).thenAnswer((_) async => []);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteProvider.getApodList(any, any))
          .thenThrow(ServerException('Server error'));

      final result = await repository.getApodList(startDate, endDate);

      expect(result.isLeft(), true);
      expect((result as Left).value, isA<ServerFailure>());
    });
  });

  group('getApodByDate', () {
    final date = DateTime(2024, 3, 15);
    const tApodModel = ApodModel(
      date: '2024-03-15',
      title: 'Test Title',
      explanation: 'Test Explanation',
      url: 'https://example.com/image.jpg',
      mediaType: 'image',
    );
    final tApodHiveModel = ApodHiveModel(
      date: '2024-03-15',
      title: 'Test Title',
      explanation: 'Test Explanation',
      url: 'https://example.com/image.jpg',
      mediaType: 'image',
    );

    test('should fetch from remote and cache when online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteProvider.getApodByDate(any))
          .thenAnswer((_) async => tApodModel);
      when(mockLocalProvider.cacheApod(any)).thenAnswer((_) async => {});

      // act
      final result = await repository.getApodByDate(date);

      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteProvider.getApodByDate(any));
      verify(mockLocalProvider.cacheApod(any));
      expect(result.isRight(), true);
      expect((result as Right).value, isA<Apod>());
    });

    test('should return cached data when offline', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalProvider.getApodByDate(any))
          .thenAnswer((_) async => tApodHiveModel);

      // act
      final result = await repository.getApodByDate(date);

      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockLocalProvider.getApodByDate(any));
      expect(result.isRight(), true);
      expect((result as Right).value, isA<Apod>());
    });

    test('should return CacheFailure when offline and no cache', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalProvider.getApodByDate(any)).thenThrow(CacheException());

      // act
      final result = await repository.getApodByDate(date);

      // assert
      expect(
        result,
        equals(const Left(CacheFailure('No cached data found'))),
      );
    });

    test('should return ServerFailure when remote call fails', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteProvider.getApodByDate(any))
          .thenThrow(ServerException('Server error'));

      // act
      final result = await repository.getApodByDate(date);

      // assert
      expect(
        result,
        equals(const Left(ServerFailure('Failed to fetch data from server'))),
      );
    });
  });

  group('searchApods', () {
    final tApodHiveModel = ApodHiveModel(
      date: '2024-03-15',
      title: 'Test Title',
      explanation: 'Test Explanation',
      url: 'https://example.com/image.jpg',
      mediaType: 'image',
    );

    test('should return filtered list based on title', () async {
      // arrange
      when(mockLocalProvider.getApodList())
          .thenAnswer((_) async => [tApodHiveModel]);

      // act
      final result = await repository.searchApods('test');

      // assert
      verify(mockLocalProvider.getApodList());
      expect(result.isRight(), true);
      expect((result as Right).value, isA<List<Apod>>());
    });

    test('should return filtered list based on date', () async {
      // arrange
      when(mockLocalProvider.getApodList())
          .thenAnswer((_) async => [tApodHiveModel]);

      // act
      final result = await repository.searchApods('2024');

      // assert
      verify(mockLocalProvider.getApodList());
      expect(result.isRight(), true);
      expect((result as Right).value, isA<List<Apod>>());
    });

    test('should return empty list when no matches found', () async {
      // arrange
      when(mockLocalProvider.getApodList())
          .thenAnswer((_) async => [tApodHiveModel]);

      // act
      final result = await repository.searchApods('nonexistent');

      // assert
      verify(mockLocalProvider.getApodList());
      expect(result.isRight(), true);
      expect((result as Right).value, isEmpty);
    });

    test('should return CacheFailure when local provider fails', () async {
      // arrange
      when(mockLocalProvider.getApodList()).thenThrow(CacheException());

      // act
      final result = await repository.searchApods('test');

      // assert
      expect(
        result,
        equals(const Left(CacheFailure('No cached data found'))),
      );
    });
  });

  group('clearCache', () {
    test('should clear cache successfully', () async {
      // arrange
      when(mockLocalProvider.clearCache()).thenAnswer((_) async => {});

      // act
      await repository.clearCache();

      // assert
      verify(mockLocalProvider.clearCache());
    });

    test('should throw CacheFailure when clearing cache fails', () async {
      // arrange
      when(mockLocalProvider.clearCache()).thenThrow(CacheException());

      // act
      final call = repository.clearCache;

      // assert
      expect(
        () => call(),
        throwsA(const CacheFailure('Failed to clear cache')),
      );
    });
  });
}
