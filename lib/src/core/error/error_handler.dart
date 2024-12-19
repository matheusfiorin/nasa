import 'package:dartz/dartz.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/core/error/failures.dart';

class ErrorHandler {
  static Future<Either<Failure, T>> handleRepositoryCall<T>({
    required Future<T> Function() call,
    String? serverErrorMessage,
    String? cacheErrorMessage,
  }) async {
    try {
      final result = await call();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(serverErrorMessage ?? e.toString()));
    } on CacheException {
      return Left(CacheFailure(cacheErrorMessage ?? 'Cache operation failed'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
