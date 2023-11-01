import 'package:dartz/dartz.dart';
import 'failures.dart';

typedef Which<T> = Either<Failure, T>;
typedef Result<T> = Future<Which<T>>;
