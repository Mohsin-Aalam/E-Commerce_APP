import 'package:intl/intl.dart';

class Formatter {
  static String formatPrice(num price) {
    final numberFormatter = NumberFormat('₹ #,##,###');
    return numberFormatter.format(price);
  }

  static String formatDate(DateTime date) {
    DateTime localDate = date.toLocal();
    final dateFormat = DateFormat("dd MMM y, hh:mm a");
    return dateFormat.format(localDate);
  }
}
