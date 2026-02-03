// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExportModelAdapter extends TypeAdapter<ExportModel> {
  @override
  final int typeId = 3;

  @override
  ExportModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExportModel(
      year: fields[0] as int,
      days: (fields[1] as List).cast<DayModel>(),
      settings: fields[2] as SettingsModel,
      exportDate: fields[3] as DateTime,
      checksum: fields[5] as String,
      version: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExportModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.days)
      ..writeByte(2)
      ..write(obj.settings)
      ..writeByte(3)
      ..write(obj.exportDate)
      ..writeByte(4)
      ..write(obj.version)
      ..writeByte(5)
      ..write(obj.checksum);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExportModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
