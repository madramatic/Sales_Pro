import 'package:dartz/dartz.dart';
import 'package:sales_pro/core/error/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid<T> = Future<Either<Failure, void>>;