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
  num get inMinutes => num.parse(hour) * 60 + num.parse(minute);

  Time differenceWith(Time other) => (inMinutes - other.inMinutes).minuteToTime;

  double percentOf(Time other) {
    print(double.parse((inMinutes / other.inMinutes).toStringAsFixed(2)));
    return double.parse((inMinutes / other.inMinutes).toStringAsFixed(2));
  }

  Time add(Time other) {
    final res = inMinutes + other.inMinutes;
    return res.minuteToTime;
  }

  Time padLeft({int length = 2, String char = '0'}) {
    return Time(
      hour: hour.padLeft(length, char),
      minute: minute.padLeft(length, char),
    );
  }
}

extension ToTime on int {
  Time get time => Time(hour: toString(), minute: '00').padLeft();
}

extension ToTimeFromNum on num {
  Time get minuteToTime {
    final hours = (this / 60).floor();
    final minutes = (this % 60).floor();
    return Time(hour: hours.toString(), minute: minutes.toString()).padLeft();
  }
}
