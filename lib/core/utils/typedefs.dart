import 'package:education_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef DataMap = Map<String, dynamic>;
