import 'package:equatable/equatable.dart';

class Time extends Equatable {
  final String hour;
  final String minute;
  const Time({required this.hour, required this.minute});

  num get toMinutes => num.parse(hour) * 60 + num.parse(minute);

  @override
  String toString() => '$hour:$minute';

  Time operator +(Time other) {
    final res = toMinutes + other.toMinutes;
    return res.minuteToTime;
  }

  Time operator -(Time other) {
    final res = toMinutes - other.toMinutes;
    return res.minuteToTime;
  }

  bool operator >(Time other) => toMinutes > other.toMinutes;
  bool operator <(Time other) => toMinutes < other.toMinutes;
  bool operator >=(Time other) => toMinutes >= other.toMinutes;
  bool operator <=(Time other) => toMinutes <= other.toMinutes;

  @override
  List<Object?> get props => [hour, minute];
}

extension HowLong on Time {
  bool isBetween(Time start, Time end) => (start < this && this < end) || (this == start || this == end);
  Time differenceWith(Time other) => (toMinutes - other.toMinutes).minuteToTime.padLeft();

  double percentOf(Time other) {
    return double.parse((toMinutes / other.toMinutes).toStringAsFixed(2));
  }

  bool equals(Time other) => toMinutes == other.toMinutes;

  bool isNotZero() => toMinutes != 0;

  Time add(Time other) {
    final res = toMinutes + other.toMinutes;
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
