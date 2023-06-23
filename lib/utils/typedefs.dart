import 'package:dartz/dartz.dart';
import 'failures.dart';

typedef Result<T> = Future<Either<Failure, T>>;
typedef Which<T> = Either<Failure, T>;
