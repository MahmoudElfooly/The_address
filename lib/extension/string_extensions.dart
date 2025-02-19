import 'package:intl/intl.dart';

extension DateFormatter on String {
  String toFormattedDate() {
    try {
      DateTime parsedDate =
          DateTime.parse(this); // Parse the string to DateTime
      return DateFormat("dd MMM yyyy")
          .format(parsedDate); // Format as "11 Feb 2025"
    } catch (e) {
      return this; // Return original string if parsing fails
    }
  }
}
