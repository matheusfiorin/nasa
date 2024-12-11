import 'package:nasa/src/data/model/apod_hive_model.dart';

abstract class ApodLocalProvider {
  Future<List<ApodHiveModel>> getApodList();

  Future<ApodHiveModel?> getApodByDate(String date);

  Future<void> cacheApodList(List<ApodHiveModel> apodList);

  Future<void> cacheApod(ApodHiveModel apod);

  Future<void> clearCache();
}
