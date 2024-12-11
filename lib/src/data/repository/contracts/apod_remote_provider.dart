import 'package:nasa/src/data/model/apod_model.dart';

abstract class ApodRemoteProvider {
  Future<List<ApodModel>> getApodList(String startDate, String endDate);

  Future<ApodModel> getApodByDate(String date);
}
