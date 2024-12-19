import 'package:flutter_test/flutter_test.dart';
import 'package:nasa/src/core/error/error_handler.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/core/error/failures.dart';

void main() {
  group('ErrorHandler', () {
    test('should return Right with result when call succeeds', () async {
      final result = await ErrorHandler.handleRepositoryCall<String>(
        call: () async => 'success',
      );

      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => ''), equals('success'));
    });

    test('should return Left with ServerFailure when ServerException occurs', () async {
      final result = await ErrorHandler.handleRepositoryCall<String>(
        call: () async => throw ServerException('Test error'),
        serverErrorMessage: 'Custom server error',
      );

      expect(result.isLeft(), isTrue);
      final failure = result.fold((l) => l, (r) => null);
      expect(failure, isA<ServerFailure>());
      expect((failure as ServerFailure).message, equals('Custom server error'));
    });

    test('should return Left with CacheFailure when CacheException occurs', () async {
      final result = await ErrorHandler.handleRepositoryCall<String>(
        call: () async => throw CacheException(),
        cacheErrorMessage: 'Custom cache error',
      );

      expect(result.isLeft(), isTrue);
      final failure = result.fold((l) => l, (r) => null);
      expect(failure, isA<CacheFailure>());
      expect((failure as CacheFailure).message, equals('Custom cache error'));
    });

    test('should return Left with ServerFailure for unexpected errors', () async {
      final result = await ErrorHandler.handleRepositoryCall<String>(
        call: () async => throw Exception('Unexpected'),
      );

      expect(result.isLeft(), isTrue);
      final failure = result.fold((l) => l, (r) => null);
      expect(failure, isA<ServerFailure>());
      expect((failure as ServerFailure).message, contains('Unexpected error'));
    });
  });
}