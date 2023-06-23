import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../utils/failures.dart';
import '../utils/typedefs.dart';

abstract interface class RepoHandler {
  Result<T> handle<T, R>({
    required Future<R> Function() onCall,
    required T Function(R) onSuccess,
    String onErrorMessage = '',
  });
}

@Injectable(as: RepoHandler)
class RepoHandlerImpl implements RepoHandler {
  @override
  Result<T> handle<T, R>({
    required Future<R> Function() onCall,
    required T Function(R) onSuccess,
    String onErrorMessage = '',
  }) async {
    try {
      final result = await onCall();
      if (result == null && onErrorMessage.isNotEmpty) return Left(DBFailure(onErrorMessage));
      return Right(onSuccess(result));
    } on Exception catch (e) {
      return Left(DBFailure(e.toString()));
    }
  }
}
