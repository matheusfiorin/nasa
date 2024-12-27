import 'package:nasa/src/domain/entity/apod.dart';
import 'package:nasa/src/presentation/feature/apod_list/model/apod_ui_model.dart';

class ApodDataManager {
  List<ApodUiModel> convertToUiModels(List<Apod> apods) {
    return apods.map((apod) => ApodUiModel.fromEntity(apod)).toList();
  }

  DateTime? getOldestDate(List<Apod> apods) {
    if (apods.isEmpty) return null;
    return DateTime.parse(apods.last.date);
  }

  List<Apod> getUniqueApods(List<Apod> apods) {
    final sortedApods = List<Apod>.from(apods)
      ..sort((a, b) => b.date.compareTo(a.date));

    return Map<String, Apod>.fromEntries(
      sortedApods.map((apod) => MapEntry(apod.date, apod)),
    ).values.toList();
  }
}
