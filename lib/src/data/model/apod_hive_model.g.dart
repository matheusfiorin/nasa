// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apod_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApodHiveModelAdapter extends TypeAdapter<ApodHiveModel> {
  @override
  final int typeId = 0;

  @override
  ApodHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApodHiveModel(
      date: fields[0] as String,
      title: fields[1] as String,
      explanation: fields[2] as String,
      url: fields[3] as String,
      mediaType: fields[4] as String,
      copyright: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ApodHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.explanation)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.mediaType)
      ..writeByte(5)
      ..write(obj.copyright);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApodHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
