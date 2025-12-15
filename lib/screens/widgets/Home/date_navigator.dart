import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateNavigator extends StatelessWidget {
  final DateTime currentDate;
  final Function() onPreviousDay;
  final Function() onNextDay;

  const DateNavigator({
    super.key,
    required this.currentDate,
    required this.onPreviousDay,
    required this.onNextDay,
  });

  String _formatDate(DateTime date) {
    final now = DateTime.now().toUtc().copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    final isToday = date.isAtSameMomentAs(now);

    if (isToday) {
      return 'HOJE, ${DateFormat('d MMMM', 'pt_BR').format(date).toUpperCase()}';
    }
    return DateFormat('EEEE, d MMMM', 'pt_BR').format(date).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().toUtc().copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    final isToday = currentDate.isAtSameMomentAs(today);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.grey, size: 24),
          onPressed: onPreviousDay,
        ),
        Text(
          _formatDate(currentDate),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
          onPressed: isToday ? null : onNextDay,
        ),
      ],
    );
  }
}
