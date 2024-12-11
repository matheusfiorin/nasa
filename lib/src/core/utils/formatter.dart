import 'package:intl/intl.dart';
import 'package:nasa/src/domain/entity/apod.dart';

class Formatter {
  static String copyright(String c) =>
      c.toString().trim().replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ');

  static String date(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

  static String? extractVideoId(String? url) {
    if (url == null) return null;

    final regex = RegExp(
      r'(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
    );

    final match = regex.firstMatch(url);
    return match?.group(1);
  }

  static DateTime findOldestDate(List<Apod> apods) {
    return DateTime.parse(
      apods.map((a) => a.date).reduce((a, b) => a.compareTo(b) < 0 ? a : b),
    );
  }
}
