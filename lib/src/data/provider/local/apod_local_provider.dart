import 'package:hive/hive.dart';
import 'package:nasa/src/core/error/exceptions.dart';
import 'package:nasa/src/data/model/apod_hive_model.dart';

abstract class ApodLocalDataSource {
  Future<List<ApodHiveModel>> getApodList();

  Future<void> cacheApodList(List<ApodHiveModel> apodList);

  Future<ApodHiveModel?> getApodByDate(String date);

  Future<void> cacheApod(ApodHiveModel apod);
}

class ApodLocalDataSourceImpl implements ApodLocalDataSource {
  final Box<ApodHiveModel> apodBox;

  ApodLocalDataSourceImpl({required this.apodBox});

  @override
  Future<List<ApodHiveModel>> getApodList() async {
    try {
      return apodBox.values.toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheApodList(List<ApodHiveModel> apodList) async {
    try {
      await apodBox.clear();
      await apodBox.addAll(apodList);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<ApodHiveModel?> getApodByDate(String date) async {
    try {
      return apodBox.values.firstWhere(
        (apod) => apod.date == date,
        orElse: () => throw CacheException(),
      );
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheApod(ApodHiveModel apod) async {
    try {
      await apodBox.put(apod.date, apod);
    } catch (e) {
      throw CacheException();
    }
  }
}
