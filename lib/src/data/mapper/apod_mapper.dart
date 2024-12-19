import 'package:nasa/src/data/model/apod_hive_model.dart';
import 'package:nasa/src/domain/entity/apod.dart';

class ApodMapper {
  static ApodHiveModel toHiveModel(Apod apod) => ApodHiveModel.fromApod(apod);

  static Apod toEntity(ApodHiveModel model) => model.toEntity();

  static List<Apod> toEntityList(List<ApodHiveModel> models) {
    return models.map((model) => toEntity(model)).toList();
  }

  static List<ApodHiveModel> toHiveModelList(List<Apod> apods) {
    return apods.map((apod) => toHiveModel(apod)).toList();
  }
}
