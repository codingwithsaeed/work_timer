import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String error;
  const Failure(this.error);

  @override
  List<Object?> get props => [error];
}

class DBFailure extends Failure {
  const DBFailure(String error) : super(error);
}
