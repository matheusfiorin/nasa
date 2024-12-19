import 'package:intl/intl.dart';
import 'package:nasa/src/domain/entity/apod.dart';

class ApodFilter {
  static const _dateFormat = 'yyyy-MM-dd';

  static List<Apod> byDateRange(
      List<Apod> apods,
      DateTime startDate,
      DateTime endDate,
      ) {
    final formatter = DateFormat(_dateFormat);
    return apods.where((apod) {
      final apodDate = formatter.parse(apod.date);
      return apodDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
          apodDate.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  static List<Apod> bySearchQuery(List<Apod> apods, String query) {
    final lowercaseQuery = query.toLowerCase();
    return apods.where((apod) =>
    apod.title.toLowerCase().contains(lowercaseQuery) ||
        apod.date.contains(query)
    ).toList();
  }
}
