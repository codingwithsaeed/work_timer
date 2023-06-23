import 'package:equatable/equatable.dart';

class Time extends Equatable {
  final String hour;
  final String minute;
  const Time({required this.hour, required this.minute});

  @override
  String toString() => '$hour:$minute';

  @override
  List<Object?> get props => [hour, minute];
}
