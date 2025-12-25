// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsModelAdapter extends TypeAdapter<SettingsModel> {
  @override
  final int typeId = 2;

  @override
  SettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsModel(
      themeMode: fields[0] as String,
      languageCode: fields[1] as String,
      showEmojis: fields[2] as bool,
      showAnimations: fields[3] as bool,
      showConfetti: fields[4] as bool,
      lastBackupDate: fields[5] as DateTime?,
      autoBackupEnabled: fields[6] as bool,
      notificationsEnabled: fields[7] as bool,
      notificationTime: fields[8] as String,
      firstLaunchCompleted: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.themeMode)
      ..writeByte(1)
      ..write(obj.languageCode)
      ..writeByte(2)
      ..write(obj.showEmojis)
      ..writeByte(3)
      ..write(obj.showAnimations)
      ..writeByte(4)
      ..write(obj.showConfetti)
      ..writeByte(5)
      ..write(obj.lastBackupDate)
      ..writeByte(6)
      ..write(obj.autoBackupEnabled)
      ..writeByte(7)
      ..write(obj.notificationsEnabled)
      ..writeByte(8)
      ..write(obj.notificationTime)
      ..writeByte(9)
      ..write(obj.firstLaunchCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
