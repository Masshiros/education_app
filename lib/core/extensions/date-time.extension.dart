import 'package:education_app/core/extensions/int.extension.dart';

extension DateTimeExtension on DateTime{
  String get timeAgo {
    final nowUtc = DateTime.now().toUtc();

    final difference = nowUtc.difference(toUtc());

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years.pluralize} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months.pluralize} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays.pluralize} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours.pluralize} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} '
          'minute${difference.inMinutes.pluralize} ago';
    } else {
      return 'now';
    }
  }
}