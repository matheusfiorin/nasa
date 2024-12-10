import 'package:hive/hive.dart';
import 'apod_hive_model.dart';

class ApodHiveModelAdapter extends TypeAdapter<ApodHiveModel> {
  @override
  final int typeId = 0;

  @override
  ApodHiveModel read(BinaryReader reader) {
    return ApodHiveModel(
      date: reader.readString(),
      title: reader.readString(),
      explanation: reader.readString(),
      url: reader.readString(),
      mediaType: reader.readString(),
      copyright: reader.readString(),
      hdUrl: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ApodHiveModel obj) {
    writer.writeString(obj.date);
    writer.writeString(obj.title);
    writer.writeString(obj.explanation);
    writer.writeString(obj.url);
    writer.writeString(obj.mediaType);
    writer.writeString(obj.copyright ?? '');
    writer.writeString(obj.hdUrl ?? '');
  }
}
