import 'package:equatable/equatable.dart';

class Time extends Equatable {
  final String hour;
  final String minute;
  const Time({required this.hour, required this.minute});

  @override
  String toString() => '$hour : $minute';

  @override
  List<Object?> get props => [hour, minute];
}

extension HowLong on Time {
  Time differenceWith(Time other) {
    return Time(
      hour: (int.parse(hour) - int.parse(other.hour)).toString(),
      minute: (int.parse(minute) - int.parse(other.minute)).toString(),
    );
  }

  Time get toHour {
    return Time(
      hour: (int.parse(hour) + (int.parse(minute) / 60)).toStringAsFixed(1),
      minute: '0',
    );
  }

  String percentOf(Time other) {
    return ((double.parse(toHour.hour) / double.parse(other.hour)) / 100).toStringAsFixed(1);
  }

  Time add(Time other) {
    return Time(
      hour: (int.parse(hour) + int.parse(other.hour)).toString(),
      minute: (int.parse(minute) + int.parse(other.minute)).toString(),
    );
  }
}

extension ToTime on int {
  Time get time {
    return Time(
      hour: toString(),
      minute: '0',
    );
  }
}
